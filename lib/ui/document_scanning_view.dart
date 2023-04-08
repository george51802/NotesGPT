import 'dart:convert';
import 'dart:io';
import 'package:auth/auth.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesgpt/net/ocr_functions.dart';
import 'package:http/http.dart' as http;

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

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    if (widget.cameras.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No camera available."),
        ),
      );
      return;
    }

    final cameraController =
        CameraController(widget.cameras[0], ResolutionPreset.max);
    await cameraController.initialize();

    final image = await cameraController.takePicture();
    setState(() {
      _image = File(image.path);
    });

    await cameraController.dispose();
  }

  Future<void> _performOCR() async {
    if (_image == null) {
      return;
    }

    try {
      final text = await performOCR(_image!);
      setState(() {
        _extractedText = text;
        _showNotesDialog(context);
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
                _sendToChatGPT(_extractedText);
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
                _sendToChatGPT(_extractedText);
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

  Future<void> _sendToChatGPT(String transcription) async {
    final apiKey =
        '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'; // Replace with your actual API key
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Scanning'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null
                ? Image.file(
                    _image!,
                    width: MediaQuery.of(context).size.width * 0.8,
                  )
                : Text('No image selected'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick an Image'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _takePhoto,
              child: Text('Take a Photo'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _performOCR,
              child: Text(
                'Scan Text',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
