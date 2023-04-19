import 'dart:convert';
import 'dart:io';
import 'package:auth/auth.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesgpt/net/ocr_functions.dart';
import 'package:http/http.dart' as http;
import 'package:edge_detection/edge_detection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'notes_library.dart';

class DocumentScanningView extends StatefulWidget {
  final List<CameraDescription> cameras;

  DocumentScanningView({required this.cameras});

  @override
  _DocumentScanningViewState createState() => _DocumentScanningViewState();
}

class _DocumentScanningViewState extends State<DocumentScanningView> {
  File? _image;
  String _extractedText = '';
  int _selectedIndex = 0;
  BuildContext? _parentContext;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhoto(BuildContext context) async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      print("Error: Camera permission not granted");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: Camera permission not granted"),
        ),
      );
      return;
    }

    String imagePath = join(
      (await getApplicationSupportDirectory()).path,
      "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg",
    );

    print("Image path: $imagePath");

    try {
      bool success = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle: 'Scanning',
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      if (success) {
        setState(() {
          _image = File(imagePath);
          print("Image path after edge detection: $imagePath");
        });
      } else {
        print('Error: Edge detection failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: Edge detection failed"),
          ),
        );
      }
    } catch (e) {
      print("Error taking photo: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error taking photo: $e"),
        ),
      );
    }
  }

  Future<void> _performOCR(BuildContext context) async {
    if (_image == null) {
      return;
    }

    try {
      final text = await performOCR(_image!);
      setState(() {
        _extractedText = text;
        _showNotesDialog(_parentContext!);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showNotesDialog(BuildContext context) async {
    TextEditingController _noteTitleController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Extracted Text:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_extractedText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Generate Notes'),
              onPressed: () {
                Navigator.of(context).pop();
                _sendToChatGPT(_parentContext!, _extractedText);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showGeneratedNotesDialog(
      BuildContext context, String gptResponse) async {
    TextEditingController _noteTitleController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Generated Notes:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(gptResponse),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
                // Call the method to regenerate the notes based on the same transcript
                _sendToChatGPT(context, _extractedText);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Save note'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            TextFormField(
                              controller: _noteTitleController,
                              decoration:
                                  InputDecoration(labelText: 'Note title'),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Save'),
                          onPressed: () async {
                            String noteTitle = _noteTitleController.text;
                            if (noteTitle.isNotEmpty) {
                              FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .collection('Notes')
                                  .doc(noteTitle)
                                  .set({'Notes': gptResponse.trim()});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotesLibrary(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendToChatGPT(
      BuildContext context, String transcription) async {
    final apiKey =
        dotenv.env['GPT_API_KEY']; // Replace with your actual API key
    final apiUrl = 'https://api.openai.com/v1/chat/completions';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final messages = [
      {
        'role': 'system',
        'content':
            'You are a helpful assistant that summarizes transcriptions. Create headers, use bullet points, and focus on the main key elements of the transcript. Organize the summary in a clear and concise manner.'
      },
      {'role': 'user', 'content': transcription},
    ];

    final body = jsonEncode({
      'messages': messages,
      'max_tokens': 2000, // Adjust the response length as needed
      'model': 'gpt-3.5-turbo'
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the response
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String GPTResponse = responseData['choices'][0]['message']['content'];
        await showGeneratedNotesDialog(context, GPTResponse);
        // print(
        //     'GPT Response: ${responseData['choices'][0]['message']['content']}');
      } else {
        // If the server returns an error, throw an exception
        print('Error Status Code: ${response.statusCode}');
        print('Error Response: ${response.body}');
        throw Exception('Failed to get response from GPT-3.5-turbo API');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          _pickImage();
          break;
        case 1:
          _takePhoto(context);
          break;
        case 2:
          _performOCR(context);
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _parentContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Scanning'),
        backgroundColor: Color(0xff1152FD),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Divider(height: 32, color: Colors.transparent),
                _image != null
                    ? FadeInImage(
                        placeholder: AssetImage(
                            'assets/loading.gif'), // Use a suitable loading gif
                        image: FileImage(_image!),
                        width: MediaQuery.of(context).size.width * 0.8,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff1152FD)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.photo_camera,
                          color: Color(0xff1152FD),
                          size: 100,
                        ),
                      ),
                Divider(height: 32, color: Colors.transparent),
                Text(
                  'Select or capture a document to scan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Divider(height: 32, color: Colors.transparent),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _onItemTapped(context, 0),
                      icon: Icon(Icons.photo_library),
                      label: Text('Gallery'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff1152FD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _onItemTapped(context, 1),
                      icon: Icon(Icons.camera_alt),
                      label: Text('Camera'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff1152FD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: 32, color: Colors.transparent),
                ElevatedButton(
                  onPressed: () => _onItemTapped(context, 2),
                  child: Text('Scan Document'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff1152FD),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
