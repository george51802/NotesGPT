import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:notesgpt/chatgpt/chat_runner.dart';
import 'package:notesgpt/chatgpt/chatpage.dart';
import 'package:notesgpt/main.dart';
import 'package:notesgpt/ui/document_scanning_view.dart';
import 'package:notesgpt/ui/settings_view.dart';
import 'package:notesgpt/ui/transcription_view.dart';
import '../chatgpt/models.dart';
import 'navigation_bar.dart';
import 'notes_library.dart';
import 'package:notesgpt/net/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:notesgpt/chatgpt/conversation_provider.dart';
import 'package:notesgpt/net/app_camera_controller.dart';

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
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xff1152FD),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    // Heading "Start taking notes"
                    Text(
                      'Start taking notes',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Start Recording button
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TranscriptionView(),
                            ),
                          );
                        },
                        icon: Icon(Icons.mic, color: Color(0xff1152FD)),
                        label: Text(
                          "Start Recording",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Document Scanning and Upload a File buttons
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final appCameraController =
                              Get.find<AppCameraController>();

                          // Initialize cameras if they are not initialized yet
                          if (appCameraController.cameras == null) {
                            await appCameraController.initCameras();
                          }

                          // Navigate to Document Scanning view
                          Get.to(DocumentScanningView(
                              cameras: appCameraController.cameras!));
                        },
                        icon: Icon(Icons.document_scanner,
                            color: Color(0xff1152FD), size: 24),
                        label: Text(
                          "Scan/upload a Document",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    // Upload a File button
                    SizedBox(height: 4),
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
                      fontFamily: 'SF-Pro',
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
                                SizedBox(
                                  height:
                                      200, // Set an appropriate height based on your design requirements
                                  child: Text(
                                    snapshot.data!.docs[index].get('Notes'),
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
