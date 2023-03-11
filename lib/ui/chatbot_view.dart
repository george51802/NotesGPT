// import 'package:flutter/material.dart';
// //import 'package:chatgpt_course/models/chat_model.dart';
// import 'package:notesgpt/net/api_service.dart';

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _textController = TextEditingController();
//   final List<ChatModel> _chatList = [];

//   void _sendMessage(String message) async {
//     _textController.clear();
//     setState(() {
//       _chatList.add(ChatModel(msg: message, chatIndex: 0));
//     });

//     final response = await ApiService.createChatCompletion([
//       {'role': 'user', 'content': message}
//     ]);

//     final List<dynamic> choices = response['choices'];
//     if (choices.isNotEmpty) {
//       setState(() {
//         _chatList.add(ChatModel(
//           msg: choices[0]['text'],
//           chatIndex: 1,
//         ));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chatbot'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _chatList
