import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

class ConversationProvider extends ChangeNotifier {
  List<Conversation> _conversations = [];
  int _currentConversationIndex = 0;
  String apikey = "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";
  String proxy = "";
  List<Conversation> get conversations => _conversations;
  int get currentConversationIndex => _currentConversationIndex;
  String get currentConversationTitle =>
      _conversations[_currentConversationIndex].title;
  int get currentConversationLength =>
      _conversations[_currentConversationIndex].messages.length;
  String get yourapikey => apikey;
  String get yourproxy => proxy;
  Conversation get currentConversation =>
      _conversations[_currentConversationIndex];
  // get current conversation's messages format
  //'messages': [
  //   {'role': 'user', 'content': text},
  // ],
  List<Map<String, String>> get currentConversationMessages {
    List<Map<String, String>> messages = [
      {
        'role': "system",
        'content': "",
      }
    ];
    for (Message message
        in _conversations[_currentConversationIndex].messages) {
      messages.add({
        'role': message.senderId == 'User' ? 'user' : 'system',
        'content': message.content
      });
    }
    return messages;
  }

  // initialize provider conversation list
  ConversationProvider() {
    _conversations.add(Conversation(messages: [], title: 'New Conversation'));
  }

  // change conversations
  set conversations(List<Conversation> value) {
    _conversations = value;
    notifyListeners();
  }

  // change current conversation
  set currentConversationIndex(int value) {
    _currentConversationIndex = value;
    notifyListeners();
  }

  set yourproxy(String value) {
    proxy = value;
    notifyListeners();
  }

  // add to current conversation
  void addMessage(Message message) {
    _conversations[_currentConversationIndex].messages.add(message);
    notifyListeners();
  }

  // add a new empty conversation
  // default title is 'new conversation ${_conversations.length}'
  void addEmptyConversation(String title) {
    if (title == '') {
      title = 'New Conversation ${_conversations.length}';
    }
    _conversations.add(Conversation(messages: [], title: title));
    _currentConversationIndex = _conversations.length - 1;
    notifyListeners();
  }

  // add new conversation
  void addConversation(Conversation conversation) {
    _conversations.add(conversation);
    _currentConversationIndex = _conversations.length - 1;
    notifyListeners();
  }

  // remove conversation by index
  void removeConversation(int index) {
    _conversations.removeAt(index);
    _currentConversationIndex = _conversations.length - 1;
    notifyListeners();
  }

  // remove current conversation
  void removeCurrentConversation() {
    _conversations.removeAt(_currentConversationIndex);
    _currentConversationIndex = _conversations.length - 1;
    if (_conversations.isEmpty) {
      addEmptyConversation('');
    }
    notifyListeners();
  }

  //rename conversation
  void renameConversation(String title) {
    if (title == "") {
      // no title, use default title
      title = 'new conversation ${_currentConversationIndex}';
    }
    _conversations[_currentConversationIndex].title = title;
    notifyListeners();
  }

  // clear all conversations
  void clearConversations() {
    _conversations.clear();
    addEmptyConversation('');
    notifyListeners();
  }

  // clear current conversation
  void clearCurrentConversation() {
    _conversations[_currentConversationIndex].messages.clear();
    notifyListeners();
  }

  // // Start transcription
  //   Future<void> startTranscription() async {
  //   // Request microphone permission
  //   PermissionStatus permissionStatus = await Permission.microphone.request();
  //   if (permissionStatus.isGranted) {
  //     // Initialize FlutterSoundRecorder
  //     FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  //     await _recorder.openRecorder();

  //     // Start recording
  //     await _recorder.startRecorder();

  //     // Stop recording after a specified duration, e.g., 5 seconds
  //     await Future.delayed(Duration(seconds: 5));

  //     // Stop the recorder
  //     String? path = await _recorder.stopRecorder();

  //     // Transcribe the recorded audio using Whisper API
  //     String transcription = await transcribeAudio(path);

  //     // Feed the transcription to ChatGPT
  //     if (transcription.isNotEmpty) {
  //       Message message = Message(content: transcription, senderId: 'User');
  //       addMessage(message);
  //       // Call the ChatGPT API with the transcription as input
  //       // Process the response and add the generated message to the conversation
  //     }
  //   } else {
  //     // Handle the case when permission is not granted
  //   }
}

const String model = "gpt-3.5-turbo";

final Sender systemSender = Sender(
    name: 'System', avatarAssetPath: 'resources/avatars/ChatGPT_logo1.png');
final Sender userSender =
    Sender(name: 'User', avatarAssetPath: 'resources/avatars/person1.png');
