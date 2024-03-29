import 'package:flutter/material.dart';
import 'package:notesgpt/ui/home_view.dart';
import 'package:provider/provider.dart';
import 'conversation_provider.dart';
import 'models.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Provider.of<ConversationProvider>(context, listen: false)
                      .addEmptyConversation('');
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Color(Colors.grey[300]?.value ?? 0)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    // left align
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.add, color: Colors.grey[800], size: 20.0),
                      const SizedBox(width: 15.0),
                      const Text(
                        'New Chat',
                        style: TextStyle(
                          fontSize: 18.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // list of conversations
            Expanded(
              child: Consumer<ConversationProvider>(
                builder: (context, conversationProvider, child) {
                  return ListView.builder(
                    itemCount: conversationProvider.conversations.length,
                    itemBuilder: (BuildContext context, int index) {
                      Conversation conversation =
                          conversationProvider.conversations[index];
                      return Dismissible(
                        key: UniqueKey(),
                        child: GestureDetector(
                          onTap: () {
                            conversationProvider.currentConversationIndex =
                                index;
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: conversationProvider
                                          .currentConversationIndex ==
                                      index
                                  ? const Color(0xff1152FD)
                                  : Colors.white,
                              // border: Border.all(color: Color(Colors.grey[200]?.value ?? 0)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // coversation icon
                                Icon(
                                  Icons.person,
                                  color: conversationProvider
                                              .currentConversationIndex ==
                                          index
                                      ? Colors.white
                                      : Colors.grey[700],
                                  size: 20.0,
                                ),
                                const SizedBox(width: 15.0),
                                Text(
                                  conversation.title,
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: conversationProvider
                                                .currentConversationIndex ==
                                            index
                                        ? Colors.white
                                        : Colors.grey[700],
                                    //fontFamily: 'din-regular',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
