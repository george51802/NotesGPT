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
          Center(
              child:
                  Image.asset('assets/noteslogo.png', width: 250, height: 500)),
          SizedBox(height: 100),
          ElevatedButton(
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
                MaterialPageRoute(builder: (context) => Authentication()),
              );
            },
          ),
          SizedBox(height: 5),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signin()),
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
        ],
      ),
    );
  }
}
