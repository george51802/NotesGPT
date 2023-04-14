import 'package:flutter/material.dart';
import 'package:notesgpt/chatgpt/conversation_provider.dart';
import 'package:provider/provider.dart';

class ChatWidget extends StatefulWidget {
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  late ConversationProvider _conversationProvider;
  late List<Widget> _messagesWidgets;

  @override
  void initState() {
    super.initState();
    _conversationProvider =
        Provider.of<ConversationProvider>(context, listen: false);
    _messagesWidgets = _buildMessagesList();
  }

  List<Widget> _buildMessagesList() {
    return _conversationProvider.currentConversationMessages
        .map((message) => _buildMessageItem(message))
        .toList();
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

    setState(() {
      _messagesWidgets = _buildMessagesList();
    });

    String response = await _conversationProvider.sendQuery(text);

    _conversationProvider
        .addMessage(Message(senderId: 'System', content: response));

    setState(() {
      _messagesWidgets = _buildMessagesList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat with NoteBot")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: _messagesWidgets,
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
