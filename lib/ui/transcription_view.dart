import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:notesgpt/ui/notes_library.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class TranscriptionView extends StatefulWidget {
  @override
  _TranscriptionViewState createState() => _TranscriptionViewState();
}

class _TranscriptionViewState extends State<TranscriptionView> {
  late TextEditingController _textEditingController;
  bool _isRecording = false;
  RecorderStream _recorder = RecorderStream();
  WebSocketChannel? _channel;
  List<String> _finalTranscripts = [];

  late StreamSubscription _recorderStatus;
  late StreamSubscription _audioStream;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    initPlugin();
  }

  // Initialize the sound_stream plugin
  Future<void> initPlugin() async {
    _recorderStatus = _recorder.status.listen((status) {
      if (mounted)
        setState(() {
          _isRecording = status == SoundStreamStatus.Playing;
        });
    });

    _audioStream = _recorder.audioStream.listen((data) {
      if (_channel != null && _isRecording) {
        String base64Data = base64Encode(data);
        try {
          _channel!.sink.add(jsonEncode({'audio_data': base64Data}));
        } catch (e) {
          // Handle the exception if needed
        }
      }
    });

    await _recorder.initialize();
  }

  void saveNote(String title, String content) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Notes')
        .doc(title)
        .set({'Notes': content});
  }

  Future<void> _sendToChatGPT(String transcription) async {
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
                _processTranscription();
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

  Future<void> _startRecording() async {
    _channel = IOWebSocketChannel.connect(
      Uri.parse(
          'wss://api.assemblyai.com/v2/realtime/ws?sample_rate=16000&api_key=b6dd910685dd449baa33c5ddd81422bb'),
      headers: {
        'Authorization': 'b6dd910685dd449baa33c5ddd81422bb',
      },
    );

    _channel!.stream.listen((message) {
      Map<String, dynamic> response = jsonDecode(message);
      String messageType = response['message_type'] ?? '';

      if (messageType == 'FinalTranscript' && response['text'] != '') {
        if (mounted) {
          setState(() {
            int audioStart = response['audio_start'] ?? 0;
            int audioEnd = response['audio_end'] ?? 0;
            int timeDifference = audioEnd - audioStart;

            if (timeDifference > 5000) {
              _finalTranscripts.add(response['text'] ?? '');
            } else {
              if (_finalTranscripts.isNotEmpty) {
                _finalTranscripts[_finalTranscripts.length - 1] +=
                    ' ' + (response['text'] ?? '');
              } else {
                _finalTranscripts.add(response['text'] ?? '');
              }
            }
          });
        }
      } else if (messageType == 'Error') {
        String errorCode = response['code'] ?? '';
        String errorMessage = response['message'] ?? '';
      }
    });

    await _recorder.start();
  }

  Future<void> _stopRecording() async {
    await _recorder.stop();
    if (_channel != null) {
      try {
        await _channel!.sink.done;
        await _channel!.sink.close();
      } catch (e) {
        // Handle the exception if needed
      }

      _channel = null;
    }
    setState(() {
      _isRecording = false;
    });
  }

  @override
  void dispose() {
    _recorderStatus.cancel();
    _audioStream.cancel();
    _channel?.sink.close();
    _textEditingController.dispose();
    super.dispose();
  }

  void _processTranscription() {
    String allTranscriptions = _finalTranscripts.join(' ');
    print('Transcriptions: $allTranscriptions');
    _sendToChatGPT(allTranscriptions);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_finalTranscripts.isNotEmpty) {
          return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Warning'),
                  content: Text(
                      'You will lose your transcription if you leave the page. Are you sure you want to leave?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Yes'),
                    ),
                  ],
                ),
              ) ??
              false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 59, 122, 246),
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.mic, color: Colors.white),
              SizedBox(width: 8),
              _isRecording
                  ? BlinkingRecordingIndicator()
                  : Text('Start Recording',
                      style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: _finalTranscripts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Segment ${index + 1}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            _finalTranscripts[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Divider(height: 1.0, thickness: 1.0),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isRecording ? _stopRecording : _startRecording,
                    child: Text(
                        _isRecording ? 'Pause Recording' : 'Start Recording',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 59, 122, 246),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  IconButton(
                    icon: Icon(Icons.check, size: 32.0),
                    onPressed: _processTranscription,
                    color: Color.fromARGB(255, 59, 122, 246),
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

class BlinkingRecordingIndicator extends StatefulWidget {
  @override
  _BlinkingRecordingIndicatorState createState() =>
      _BlinkingRecordingIndicatorState();
}

class _BlinkingRecordingIndicatorState extends State<BlinkingRecordingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Text(
          'Recording',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ),
    );
  }
}
