import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chatpage.dart';
import 'drawer.dart';
import 'conversation_provider.dart';
import 'popmenu.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ConversationProvider(),
      child: ChatBotRunner(),
    ),
  );
}

class ChatBotRunner extends StatelessWidget {
  // create theme
  final ThemeData theme = ThemeData(
    primarySwatch: Colors.grey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NoteBot',
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "test",
            style: const TextStyle(
              fontSize: 20.0, // change font size
              color: Colors.black, // change font color
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu_rounded),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          backgroundColor: Colors.grey[100],
          elevation: 0, // remove box shadow
          toolbarHeight: 50,
          actions: [
            CustomPopupMenu(),
          ],
        ),
        drawer: MyDrawer(),
        body: const Center(
          child: ChatPage(),
        ),
      ),
    );
  }
}
