import 'package:flutter/material.dart';
import 'package:notesgpt/ui/authentication.dart';
import 'sign_in_view.dart';
import 'sign_up_view.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1152FD),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Add your app logo here
          Center(child: Image.asset('assets/noteslogo.png', width: 300)),
          SizedBox(height: 32),
          ElevatedButton(
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Color(0xff1152FD),
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 130.0, vertical: 18.0),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Authentication()),
              );
            },
          ),
          SizedBox(height: 16),
          TextButton(
            child: Text('Sign In', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
