import 'package:flutter/material.dart';
import 'package:notesgpt/ui/user_sign_up.dart';
import 'user_sign_in.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isVisible = true; // Track visibility of the widgets

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1152FD),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Add your app logo here
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Center(
              child: Image.asset('assets/noteslogo.png', width: 250, height: 500),
            ),
          ),
          SizedBox(height: 150),
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: ElevatedButton(
              child: Text(
                'Create an account',
                style: TextStyle(
                  color: Color(0xff1152FD),
                  fontWeight: FontWeight.w800,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 20.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserSignUp()),
                );
              },
            ),
          ),
          SizedBox(height: 5),
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserSignIn()),
                );
              },
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: "Sign in",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
