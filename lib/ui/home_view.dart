import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesgpt/ui/chatbot_view.dart';
import 'package:notesgpt/ui/home_view.dart';
import 'package:notesgpt/ui/settings_view.dart';
import 'package:notesgpt/ui/welcome_screen.dart';

class HomeController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var currentIndex = 0.obs;

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeEndDrawer();
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }
}

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: Color(0xff1152FD),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
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
                              contentPadding: EdgeInsets.only(left: 20, top: 6),
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
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 45),
                  Container(
                    width: 60 + 16 + MediaQuery.of(context).size.width * 0.8,
                    height: 95,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        'ChatBot',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
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
                    child: Text('View All'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xff1152FD), // Change the color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                    ),
                    onPressed: () {
                      // Go to the notes library ui page
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('Coins')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView(
                        children: snapshot.data!.docs.map((document) {
                          return Container(
                              child: Row(
                            children: [
                              Text(document.id),
                              Text("${document.data()['body']}"),
                            ],
                          ));
                        }).toList(),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: (int index) {
          if (index == 3) {
            Get.to(UserSettingsView());
          } else {
            controller.changeTab(index);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded,
                color: controller.currentIndex.value == 0
                    ? Color(0xff1152FD)
                    : Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner,
                color: controller.currentIndex.value == 1
                    ? Color(0xff1152FD)
                    : Colors.grey),
            label: 'Documents',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.chat,
                  color: controller.currentIndex.value == 2
                      ? Color(0xff1152FD)
                      : Colors.grey),
              onPressed: () {
                Get.to(() => WelcomeScreen());
              },
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.person,
                  color: controller.currentIndex.value == 3
                      ? Color(0xff1152FD)
                      : Colors.grey),
              onPressed: () {
                Get.to(() => UserSettingsView());
              },
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'Welcome to the Home tab!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
