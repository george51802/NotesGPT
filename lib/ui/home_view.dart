import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:notesgpt/chatgpt/chat_runner.dart';
import 'package:notesgpt/chatgpt/chatpage.dart';
import 'package:notesgpt/ui/settings_view.dart';
import 'package:notesgpt/ui/transcription_view.dart';
import '../chatgpt/models.dart';
import 'navigation_bar.dart';
import 'notes_library.dart';
import 'package:notesgpt/net/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:notesgpt/chatgpt/conversation_provider.dart';

Future<void> addNote(String noteContent) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('Notes')
        .add({'Notes': noteContent});
  }
}

void saveNote(String title, String content) {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Notes')
      .doc(title)
      .set({'Notes': content});
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff1152FD),
          title: Image.asset(
            'assets/noteslogo3.png',
            width: 150,
            height: 52,
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3 + 40,
              decoration: BoxDecoration(
                color: Color(0xff1152FD),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 20, top: 6),
                                hintText: 'Search',
                                hintStyle: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        // Home bar Container
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                              icon: Icon(Icons.mic),
                              color: Color(0xff1152FD),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TranscriptionView(saveNote: saveNote),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text("NoteBot Conversations",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    Expanded(
                      child: Consumer<ConversationProvider>(
                        builder: (context, conversationProvider, child) {
                          return RawScrollbar(
                            thumbColor: Colors.white,
                            thickness: 5,
                            radius: Radius.circular(10),
                            padding: EdgeInsets.symmetric(horizontal: -3),
                            child: ListView.builder(
                              itemCount:
                                  conversationProvider.conversations.length,
                              itemBuilder: (BuildContext context, int index) {
                                Conversation conversation =
                                    conversationProvider.conversations[index];
                                return Dismissible(
                                  key: UniqueKey(),
                                  child: GestureDetector(
                                    onTap: () {
                                      conversationProvider
                                          .currentConversationIndex = index;
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 300,
                                      padding: const EdgeInsets.all(10.0),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 7.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        // border: Border.all(color: Color(Colors.grey[200]?.value ?? 0)),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // coversation icon
                                          Icon(
                                            Icons.person,
                                            color: Colors.grey[700],
                                            size: 20.0,
                                          ),
                                          const SizedBox(width: 15.0),
                                          Text(
                                            conversation.title,
                                            style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.grey[700],
                                              //fontFamily: 'din-regular',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, top: 20),
              child: Row(
                children: [
                  Text(
                    'Notes Library',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 60),
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff1152FD),
                    ),
                    child: ElevatedButton(
                      child: Text('View All',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xff1152FD), // Change the color here
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotesLibrary(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Center(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('Notes')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(right: 20),
                            padding: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.docs[index].id,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  snapshot.data!.docs[index].get('Notes'),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            CustomNavigationBar(
              selectedIndex: 0,
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
              },
            ),
            SizedBox(height: 20),
          ],
        ));
  }
}
