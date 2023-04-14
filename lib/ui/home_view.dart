import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notesgpt/chatgpt/chatpage.dart';
import 'package:notesgpt/ui/settings_view.dart';
import 'package:notesgpt/ui/transcription_view.dart';
import '../chatgpt/models.dart';
import 'document_scanning_view.dart';
import 'navigation_bar.dart';
import 'notes_library.dart';
import 'package:notesgpt/net/app_camera_controller.dart';

class HomeView extends StatelessWidget {
  final bool isSubscribed = true; // Set the value of isSubscribed as needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Today',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 5),
            Text(
              DateFormat('EEEE, MMMM d').format(DateTime.now()),
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _insightsContainer(context),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _homeButton(
                      context,
                      'Record',
                      'Transcribe Audio',
                      Icons.mic,
                      () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 10),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      TranscriptionView(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              }),
                        );
                      },
                    ),
                    SizedBox(width: 10),
                    _homeButton(
                      context,
                      'Pick a file',
                      'Audio/Video File',
                      Icons.file_copy,
                      () {
                        // Add code for picking a file
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _homeButton(
                      context,
                      'Scan',
                      'Documents',
                      Icons.scanner,
                      () async {
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
                    ),
                    SizedBox(width: 10),
                    _homeButton(
                      context,
                      'From URL',
                      'Audio/Video File',
                      Icons.link,
                      () {
                        // Add code for picking a file
                      },
                    ),
                  ],
                ),
                SizedBox(height: 60),
                _notesSummary(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 0,
        onTabChange: (index) {
          // ChatBot Page
          if (index == 2) {
            // Assuming ChatBot button is at index 2
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(),
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
    );
  }

  //final buttonWidth = (MediaQuery.of(context).size.width - 60) / 2;

  Widget _homeButton(BuildContext context, String title, String subtitle,
      IconData icon, VoidCallback onPressed,
      {Widget? subtitleWidget}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 150,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    Color(0xff1152FD),
                    Color.fromARGB(255, 14, 143, 255),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: Icon(icon, size: 40),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            subtitleWidget ??
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
          ],
        ),
      ),
    );
  }
}

Widget _notesSummary(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotesLibrary(),
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Color(0xff1152FD), // the base color
            Color.fromARGB(255, 59, 130,
                253), // a slightly brighter and higher contrast color
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff1152FD)
                .withOpacity(0.3), // set the color and opacity of the glow
            spreadRadius: 5, // set the spread radius of the glow
            blurRadius: 25, // set the blur radius of the glow
            offset: Offset(0, 0), // set the offset of the glow
          ),
        ],
      ),
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notes Library',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'View and manage all your notes',
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 244, 244, 244)),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}

Widget _insightsContainer(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width - 40,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Select an option to get started',
          style: TextStyle(fontSize: 20),
        ),
      ],
    ),
  );
}

Widget _insightItem(
    BuildContext context, String title, int value, String unit) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        unit,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 5),
      Text(
        value.toString(),
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
