import 'dart:convert';
import 'dart:io';
import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:notesgpt/ui/home_view.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../ui/notes_library.dart';
import '../ui/settings_view.dart';
import 'models.dart';
import 'conversation_provider.dart';
import 'package:intl/intl.dart';
import 'package:notesgpt/ui/navigation_bar.dart';
import 'chat_runner.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  HttpClient _client = HttpClient();
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<Message?> _sendMessage(List<Map<String, String>> messages) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final apiKey = dotenv.env['GPT_API_KEY'];
    final proxy =
        Provider.of<ConversationProvider>(context, listen: false).yourproxy;
    final converter = JsonUtf8Encoder();

    // send all current conversation to OpenAI
    final body = {
      'model': model,
      'messages': messages,
    };
    // _client.findProxy = HttpClient.findProxyFromEnvironment;
    if (proxy != "") {
      _client.findProxy = (url) {
        return HttpClient.findProxyFromEnvironment(url,
            environment: {"http_proxy": proxy, "https_proxy": proxy});
      };
    }

    try {
      return await _client.postUrl(url).then((HttpClientRequest request) {
        request.headers.set('Content-Type', 'application/json');
        request.headers.set('Authorization', 'Bearer $apiKey');
        request.add(converter.convert(body));
        return request.close();
      }).then((HttpClientResponse response) async {
        var retBody = await response.transform(utf8.decoder).join();
        if (response.statusCode == 200) {
          final data = json.decode(retBody);
          final completions = data['choices'] as List<dynamic>;
          if (completions.isNotEmpty) {
            final completion = completions[0];
            final content = completion['message']['content'] as String;
            // delete all the prefix '\n' in content
            final contentWithoutPrefix =
                content.replaceFirst(RegExp(r'^\n+'), '');
            return Message(
                senderId: systemSender.id, content: contentWithoutPrefix);
          }
        } else {
          // invalid api key
          // create a new dialog
          return Message(
              content: "API KEY is Invalid", senderId: systemSender.id);
        }
      });
    } on Exception catch (_) {
      return Message(content: _.toString(), senderId: systemSender.id);
    }
  }

  //scroll to last message
  void _scrollToLastMessage() {
    final double height = _scrollController.position.maxScrollExtent;
    final double lastMessageHeight =
        _scrollController.position.viewportDimension;
    _scrollController.animateTo(
      height,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Future<void> _showNotesDialog(BuildContext context) async {
    final _conversationProvider =
        Provider.of<ConversationProvider>(context, listen: false);
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user can tap outside the dialog to close it
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Notes'),
          content: Container(
            width: double.maxFinite,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userId)
                  .collection('Notes')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return ListTile(
                      title: Text(document.id),
                      onTap: () async {
                        String noteTitle = document.id;
                        String noteContent = document.get('Notes');
                        _conversationProvider.preFeedMessage(noteContent);

                        // Send a message to ChatGPT asking about the note
                        String message =
                            "Let's talk about the note '$noteTitle'.";
                        //await _sendMessageToChatGPT(message, context);

                        Navigator.of(context).pop();
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _sendMessageAndAddToChat() async {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      _textController.clear();
      final userMessage = Message(senderId: userSender.id, content: text);
      setState(() {
        // add to current conversation
        Provider.of<ConversationProvider>(context, listen: false)
            .addMessage(userMessage);
      });

      // TODO:scroll to last message
      _scrollToLastMessage();

      final assistantMessage = await _sendMessage(
          Provider.of<ConversationProvider>(context, listen: false)
              .currentConversationMessages);
      if (assistantMessage != null) {
        setState(() {
          Provider.of<ConversationProvider>(context, listen: false)
              .addMessage(assistantMessage);
        });
      }

      // TODO:scroll to last message
      _scrollToLastMessage();
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 228, 228, 228),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: Consumer<ConversationProvider>(
                builder: (context, conversationProvider, child) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: conversationProvider.currentConversationLength,
                    itemBuilder: (BuildContext context, int index) {
                      Message message = conversationProvider
                          .currentConversation.messages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: message.senderId == userSender.id
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 20.0),
                                  decoration: BoxDecoration(
                                    color: message.senderId == userSender.id
                                        ? Color(0xff1152FD)
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0),
                                      bottomLeft:
                                          message.senderId == userSender.id
                                              ? Radius.circular(16.0)
                                              : Radius.zero,
                                      bottomRight:
                                          message.senderId != userSender.id
                                              ? Radius.circular(16.0)
                                              : Radius.zero,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message.content,
                                        style: TextStyle(
                                          color:
                                              message.senderId == userSender.id
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      if (message.senderId == userSender.id)
                                        Text(
                                          DateFormat('hh:mm a')
                                              .format(message.timestamp),
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: message.senderId ==
                                                    userSender.id
                                                ? Colors.white.withOpacity(0.4)
                                                : Colors.black.withOpacity(0.0),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4.0),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // input box
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showNotesDialog(context);
                  },
                  child: Text('Select Notes',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff1152FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 228, 228, 228),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 3.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 17.0, right: 10.0),
                              child: TextField(
                                controller: _textController,
                                decoration: const InputDecoration.collapsed(
                                  hintText: 'Type here...',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff1152FD),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            icon: Icon(Icons.play_arrow, color: Colors.white),
                            onPressed: _sendMessageAndAddToChat),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CustomNavigationBar(
              selectedIndex: 2,
              onTabChange: (index) {
                // ChatBot Page
                if (index == 2) {
                  // Assuming ChatBot button is at index 2
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatBotRunner(),
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
