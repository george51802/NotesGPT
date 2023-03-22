import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesgpt/net/auth_service.dart';
import 'package:notesgpt/ui/home_view.dart';
import 'package:notesgpt/ui/welcome_screen.dart';

import '../chatgpt/chat_runner.dart';
import 'navigation_bar.dart';
import 'notes_library.dart';

class UserSettingsView extends StatelessWidget {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'User';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1152FD),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          ),
        ),
        title: Text('Settings', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Hello, $email!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(thickness: 1, height: 30),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Edit Profile'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Change Password'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text('Change Language'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Sign Out'),
                onTap: () {
                  authService.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => WelcomeScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          Spacer(),
          CustomNavigationBar(
            selectedIndex: 3,
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
    );
  }
}
