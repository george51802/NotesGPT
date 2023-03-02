import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesgpt/net/auth_service.dart';
import 'package:notesgpt/ui/welcome_screen.dart';

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
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Settings'),
      ),
      body: Column(
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
            title: Text('Change ChatGPT Model'),
            onTap: () {},
          ),
          Expanded(child: Container()),
          Center(
            child: Container(
              margin: EdgeInsets.all(40),
              child: ElevatedButton(
                child: Text('Sign Out'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff1152FD), // Change the color here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                ),
                onPressed: () {
                  authService.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => WelcomeScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
