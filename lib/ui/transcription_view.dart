import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:http/http.dart' as http;

import 'home_view.dart';

class TranscriptionView extends StatefulWidget {
  final Function(String, String) saveNote;

  TranscriptionView({required this.saveNote});

  @override
  _TranscriptionViewState createState() => _TranscriptionViewState();
}

class _TranscriptionViewState extends State<TranscriptionView> {
  SpeechToText speechToText = SpeechToText();

  var text = "Press the record button to begin.";
  var isListening = false;
  var isPaused = false;
  String previousText = "";

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    bool available = await speechToText.initialize(
      onError: (SpeechRecognitionError error) {
        print("Error: $error");
      },
      onStatus: (String status) {
        print("Status: $status");
      },
    );
    if (!available) {
      print("The user has denied the use of speech recognition.");
    }
  }

  // Future<String> generateNote(String text) async {
  //   final apiKey = "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";
  //   final url = 'https://api.openai.com/v1/engines/gpt-3.5-turbo/completions';

  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         HttpHeaders.authorizationHeader: 'Bearer $apiKey',
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //       body: json.encode({
  //         'messages': [
  //           {
  //             'role': 'system',
  //             'content':
  //                 'You are a helpful assistant that generates summary notes.',
  //           },
  //           {
  //             'role': 'user',
  //             'content':
  //                 'Generate a summary note from the following text: $text',
  //           },
  //         ],
  //         'max_tokens': 100,
  //         'n': 1,
  //         'stop': null,
  //         'temperature': 0.7,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       final choices = data['choices'];
  //       if (choices != null && choices.isNotEmpty) {
  //         return choices[0]['message']['content'].toString().trim();
  //       }
  //     } else {
  //       print('Error: API call failed with status code ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error: Exception occurred during the API call');
  //     print(e);
  //   }

  //   return 'Failed to generate a summary note.';
  // }

  List<String> words = [];

  String currentSessionText = "";

  void toggleListening() async {
    if (!isListening) {
      var available = await speechToText.initialize();
      if (available) {
        setState(() {
          isListening = true;
          currentSessionText = "";
        });

        speechToText.listen(
          onResult: (result) {
            setState(() {
              currentSessionText = result.recognizedWords;

              if (previousText.isEmpty) {
                text = currentSessionText;
              } else {
                String modifiedCurrentSessionText =
                    currentSessionText.isNotEmpty
                        ? currentSessionText[0].toLowerCase() +
                            currentSessionText.substring(1)
                        : "";
                text = previousText + " " + modifiedCurrentSessionText;
              }

              if (result.finalResult) {
                previousText = text;
              }
            });
          },
        );
      }
    } else {
      setState(() {
        isListening = false;
      });
      speechToText.stop();
    }
  }

  String noteTitle = '';

  Future<void> showSaveNoteDialog(BuildContext context) async {
    TextEditingController _noteTitleController = TextEditingController();
    return showDialog<void>(
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
                  decoration: InputDecoration(labelText: 'Note title'),
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
                noteTitle = _noteTitleController.text;
                if (noteTitle.isNotEmpty) {
                  widget.saveNote(noteTitle, text.trim());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeView(),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1152FD),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            setState(() {
              isListening = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeView(),
              ),
            );
          },
        ),
        title: Text('Generate Notes', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.03),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: "closeButton",
                    onPressed: () {
                      setState(() {
                        isListening = false;
                        text = "Press the record button to begin.";
                        previousText = "";
                        currentSessionText = "";
                      });
                      speechToText.stop();
                    },
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: "recordButton",
                    onPressed: toggleListening,
                    backgroundColor: isListening ? Colors.red : Colors.green,
                    child: Icon(
                      isListening ? Icons.pause : Icons.mic,
                      color: Colors.white,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: "checkButton",
                    onPressed: () async {
                      await showSaveNoteDialog(context);
                    },
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
