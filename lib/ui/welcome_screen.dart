import 'package:flutter/material.dart';
import 'package:notesgpt/ui/user_sign_up.dart';
import 'user_sign_in.dart';
import 'package:get/get.dart';

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
          SizedBox(height: 150),
          ElevatedButton(
            child: Text(
              'createAccount'.tr,
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
          SizedBox(height: 5),
          TextButton(
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
                    text: 'alreadyHaveAccount'.tr,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: 'signIn'.tr,
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
