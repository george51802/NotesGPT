import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notesgpt/chatgpt/chatpage.dart';
import 'package:notesgpt/ui/settings_view.dart';
import 'package:notesgpt/ui/transcription_view.dart';
import 'package:pdf_text/pdf_text.dart';
import '../chatgpt/models.dart';
import 'document_scanning_view.dart';
import 'navigation_bar.dart';
import 'notes_library.dart';
import 'package:notesgpt/net/app_camera_controller.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomeView extends StatelessWidget {
  final bool isSubscribed = true; // Set the value of isSubscribed as needed
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _transcriptionStatusController = StreamController<String>.broadcast();
  bool _isTranscribing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Today',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 5),
            Text(
              DateFormat('EEEE, MMMM d').format(DateTime.now()),
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _insightsContainer(context),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _homeButton(
                      context,
                      'Record',
                      'Transcribe Audio',
                      Icons.mic,
                      () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 10),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      TranscriptionView(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              }),
                        );
                      },
                    ),
                    SizedBox(width: 10),
                    _homeButton(
                      context,
                      'Pick a file',
                      'Audio/Video File',
                      Icons.file_copy,
                      () {
                        _pickFile(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _homeButton(
                      context,
                      'Scan',
                      'Documents',
                      Icons.scanner,
                      () async {
                        final appCameraController =
                            Get.find<AppCameraController>();

                        // Initialize cameras if they are not initialized yet
                        if (appCameraController.cameras == null) {
                          await appCameraController.initCameras();
                        }

                        // Navigate to Document Scanning view
                        Get.to(DocumentScanningView(
                            cameras: appCameraController.cameras!));
                      },
                    ),
                    SizedBox(width: 10),
                    _homeButton(
                      context,
                      'From URL',
                      'Audio/Video File',
                      Icons.link,
                      () {
                        _transcribeFromUrl(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                _notesSummary(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 0,
        onTabChange: (index) {
          // ChatBot Page
          if (index == 2) {
            // Assuming ChatBot button is at index 2
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(),
              ),
            );
          }
          // Notes Library Page
          else if (index == 1) {
            // Assuming Notes Library button is at index 1
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotesLibrary(),
              ),
            );
          }
          // Profile Page
          else if (index == 3) {
            // Assuming Profile button is at index 3
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserSettingsView(),
              ),
            );
          }
          // Home Page
          else {
            // Assuming Home button is at index 0
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeView(),
              ),
            );
          }
        },
      ),
    );
  }

  //final buttonWidth = (MediaQuery.of(context).size.width - 60) / 2;

  Widget _homeButton(BuildContext context, String title, String subtitle,
      IconData icon, VoidCallback onPressed,
      {Widget? subtitleWidget}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 150,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    Color(0xff1152FD),
                    Color.fromARGB(255, 14, 143, 255),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: Icon(icon, size: 40),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            subtitleWidget ??
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
          ],
        ),
      ),
    );
  }

  Widget _notesSummary(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotesLibrary(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Color(0xff1152FD), // the base color
              Color.fromARGB(255, 59, 130,
                  253), // a slightly brighter and higher contrast color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xff1152FD)
                  .withOpacity(0.3), // set the color and opacity of the glow
              spreadRadius: 5, // set the spread radius of the glow
              blurRadius: 25, // set the blur radius of the glow
              offset: Offset(0, 0), // set the offset of the glow
            ),
          ],
        ),
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notes Library',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'View and manage all your notes',
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 244, 244, 244)),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _insightsContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Select an option to get started',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _insightItem(
      BuildContext context, String title, int value, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          unit,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5),
        Text(
          value.toString(),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'mp3', 'wav', 'm4a'],
    );

    if (result != null) {
      final selectedFile = File(result.files.single.path!);
      final fileExtension = result.files.single.extension;

      if (fileExtension == 'pdf') {
        PDFDoc doc = await PDFDoc.fromPath(selectedFile.path);
        String text = await doc.text;

        // Do something with the extracted text
      } else if (fileExtension == 'mp3' ||
          fileExtension == 'wav' ||
          fileExtension == 'm4a') {
        print("File is audio");
        String? uploadUrl = await _uploadAudioFile(selectedFile.path);
        if (uploadUrl != null) {
          await _transcribeAudioFile(context, uploadUrl);
        }
      } else {
        print('Unsupported file type');
      }
    } else {
      print('No file selected');
    }
  }

  Future<void> _transcribeAudioFile(
      BuildContext context, String uploadUrl) async {
    var url = Uri.parse('https://api.assemblyai.com/v2/transcript');
    var headers = {
      HttpHeaders.authorizationHeader: 'b6dd910685dd449baa33c5ddd81422bb',
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    var body = jsonEncode({'audio_url': uploadUrl});
    _isTranscribing = true;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Transcribing audio..."),
            ],
          ),
        );
      },
    );

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String transcriptionId = jsonResponse['id'];

      // Poll for transcription completion and retrieve the transcription text
      bool transcriptionCompleted = false;
      while (!transcriptionCompleted) {
        await Future.delayed(Duration(seconds: 5));
        var statusResponse = await http.get(
          Uri.parse(
              'https://api.assemblyai.com/v2/transcript/$transcriptionId'),
          headers: headers,
        );

        if (statusResponse.statusCode == 200) {
          var statusJson = jsonDecode(statusResponse.body);
          String status = statusJson['status'];

          // Update the status to 'completed'
          if (status == 'completed') {
            transcriptionCompleted = true;
            _isTranscribing = false;
            _transcriptionStatusController.add('completed');
            print('Transcription: ${statusJson['text']}');
            Navigator.pop(context); // Dismiss the loading dialog
            displayNotesDialog(context, statusJson['text']);
          }

          // Update the status to 'error'
          if (status == 'error') {
            transcriptionCompleted = true;
            _transcriptionStatusController.add('error');
            print(
                'Error during transcription: ${statusJson['detail']} for file: $transcriptionId');
            Navigator.pop(context); // Dismiss the loading dialog
          }
        } else {
          transcriptionCompleted = true;
          Navigator.pop(context); // Dismiss the loading dialog
          print(
              'Error checking transcription status: ${response.reasonPhrase}');
        }
      }
    } else {
      Navigator.pop(context); // Dismiss the loading dialog
      print(
          'Error submitting audio file for transcription: ${response.reasonPhrase}');
    }
  }

  Future<String?> _uploadAudioFile(String filePath) async {
    var url = Uri.parse('https://api.assemblyai.com/v2/upload');
    var request = http.MultipartRequest('POST', url);
    request.headers[HttpHeaders.authorizationHeader] =
        'b6dd910685dd449baa33c5ddd81422bb';

    File file = File(filePath);
    request.files.add(http.MultipartFile(
      'file',
      ChunkedFileByteStream(file).stream,
      await file.length(),
      filename: file.path.split('/').last,
    ));

    var response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(await response.stream.bytesToString());
      return jsonResponse['upload_url'];
    } else {
      print('Error uploading audio file: ${response.reasonPhrase}');
      return null;
    }
  }

  Future<void> _transcribeFromUrl(BuildContext context) async {
    TextEditingController urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Audio URL"),
          content: TextField(
            controller: urlController,
            decoration: InputDecoration(hintText: "Enter audio file URL"),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("Submit"),
              onPressed: () async {
                _isTranscribing = true;
                String url = urlController.text;
                if (url.isNotEmpty) {
                  Navigator.pop(context);
                  await _transcribeAudioFile(_scaffoldKey.currentContext!, url);

                  showDialog(
                    context: _scaffoldKey.currentContext!,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return StreamBuilder<String>(
                          stream: _transcriptionStatusController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data == 'completed') {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.pop(context);
                              });
                            }
                            return AlertDialog(
                              content: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 20),
                                  Text("Transcribing audio..."),
                                ],
                              ),
                            );
                          });
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void displayNotesDialog(BuildContext context, String transcription) async {
    // Call the _sendToChatGPT method with the transcription
    await _sendToChatGPT(context, transcription);
  }

  void saveNote(String title, String content) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Notes')
        .doc(title)
        .set({'Notes': content});
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
                _sendToChatGPT(context, gptResponse);
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

  @override
  void dispose() {
    _transcriptionStatusController.close();
  }
}

class ChunkedFileByteStream extends http.ByteStream {
  final int _chunkSize;
  final File _file;
  late Stream<List<int>> _stream;

  ChunkedFileByteStream(this._file, {int chunkSize = 5242880})
      : _chunkSize = chunkSize,
        super(Stream.empty()) {
    _stream = _file.openRead().transform(
      StreamTransformer.fromHandlers(
        handleData: (List<int> data, EventSink<List<int>> sink) {
          int start = 0;
          while (start < data.length) {
            int end = start + _chunkSize;
            if (end > data.length) end = data.length;
            sink.add(data.sublist(start, end));
            start = end;
          }
        },
      ),
    ).asBroadcastStream();
  }

  @override
  Stream<List<int>> get stream => _stream;
}
