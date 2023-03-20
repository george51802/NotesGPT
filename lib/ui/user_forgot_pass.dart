import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notesgpt/net/flutterfire.dart';
import 'package:notesgpt/ui/user_sign_in.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailField = TextEditingController();

  @override
  void dispose() {
    _emailField.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailField.text.trim());
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            'Password reset link sent to your email',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          width: 300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Color(0xff1152FD),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.message!.isNotEmpty || e.message != null) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              e.message.toString(),
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            width: 300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              "Forgot Password?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Don't worry! It happens. Please enter the email address associated with this account and we’ll send you a link to reset your password.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: Color.fromARGB(
                  255,
                  255,
                  255,
                  255,
                ), // light gray background
                border: Border.all(
                  color: Color.fromARGB(
                    255,
                    221,
                    221,
                    221,
                  ), // gray border
                ),
                borderRadius: BorderRadius.circular(
                  18.0,
                ), // border radius
              ),
              child: TextFormField(
                controller: _emailField,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(
                    color: Color.fromARGB(
                      255,
                      145,
                      145,
                      145,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(
                    18.0,
                    5.0,
                    0.0,
                    0.0,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: 330,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff1152FD).withOpacity(
                        0.3), // set the color and opacity of the glow
                    spreadRadius: 5, // set the spread radius of the glow
                    blurRadius: 25, // set the blur radius of the glow
                    offset: Offset(0, 0), // set the offset of the glow
                  ),
                ],
                color: Color(0xff1152FD),
              ),
              child: MaterialButton(
                onPressed: () => passwordReset(),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserSignIn();
                      },
                    ),
                  );
                },
                child: Text(
                  'Back to Login',
                  style: TextStyle(
                    color: Color(0xff1152FD),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
