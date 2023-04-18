import 'package:flutter/material.dart';
import 'package:notesgpt/chatgpt/conversation_provider.dart';
import 'package:provider/provider.dart';

import 'models.dart';

class ChatWidget extends StatefulWidget {
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  late ConversationProvider _conversationProvider;

  @override
  void initState() {
    super.initState();
    _conversationProvider =
        Provider.of<ConversationProvider>(context, listen: false);
  }

  Widget _buildMessageItem(Map<String, String> message) {
    bool isUserMessage = message['role'] == 'user';
    return ListTile(
      title: Text(
        message['content']!,
        style: TextStyle(color: isUserMessage ? Colors.blue : Colors.black),
      ),
      leading: isUserMessage ? null : Icon(Icons.chat_bubble_outline),
      trailing: isUserMessage ? Icon(Icons.chat_bubble_outline) : null,
    );
  }

  void _handleSubmitted(String text) async {
    _textEditingController.clear();
    _conversationProvider.preFeedMessage(text);

    String response = await _conversationProvider.sendQuery(text);

    _conversationProvider
        .addMessage(Message(senderId: 'System', content: response));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat with NoteBot")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount:
                    _conversationProvider.currentConversationMessages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildMessageItem(
                      _conversationProvider.currentConversationMessages[index]);
                },
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textEditingController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textEditingController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
