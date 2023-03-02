import 'package:notesgpt/net/auth_service.dart';
import 'package:notesgpt/net/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:notesgpt/ui/sign_in_view.dart';

import 'home_view.dart';
import 'welcome_screen.dart';

class Authentication extends StatefulWidget {
  Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
              );
            },
          ),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text("Create an account",
                style: TextStyle(color: Colors.black, fontSize: 25.0)),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 1.3,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "E-mail",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 330,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 244, 244, 244), // light gray background
                      border: Border.all(
                        color:
                            Color.fromARGB(255, 221, 221, 221), // gray border
                      ),
                      borderRadius:
                          BorderRadius.circular(18.0), // border radius
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black), // black text color
                      controller: _emailField,
                      decoration: InputDecoration(
                        hintText: "example@gmail.com",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 221, 221,
                                221)), // set hint text color to gray
                        contentPadding:
                            EdgeInsets.fromLTRB(18.0, 20.0, 16.0, 8.0),
                        border: InputBorder.none, // remove underline
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Password",
                      style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  SizedBox(height: 10),
                  Container(
                    width: 330,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 244, 244, 244), // light gray background
                      border: Border.all(
                        color:
                            Color.fromARGB(255, 221, 221, 221), // gray border
                      ),
                      borderRadius:
                          BorderRadius.circular(18.0), // border radius
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black), // black text color
                      controller: _passwordField,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "••••••••••••",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 221, 221,
                                221)), // set hint text color to gray
                        contentPadding:
                            EdgeInsets.fromLTRB(18.0, 20.0, 16.0, 8.0),
                        border: InputBorder.none, // remove underline
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Container(
                width: 330,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff1152FD).withOpacity(
                          0.5), // set the color and opacity of the glow
                      spreadRadius: 5, // set the spread radius of the glow
                      blurRadius: 25, // set the blur radius of the glow
                      offset: Offset(0, 0), // set the offset of the glow
                    ),
                  ],
                  color: Color(0xff1152FD),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate =
                        await register(_emailField.text, _passwordField.text);
                    if (shouldNavigate) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeView(),
                        ),
                      );
                    }
                  },
                  child: Text("Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.3,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text("Or sign up with"),
                    SizedBox(width: 10),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color.fromARGB(255, 208, 208, 208),
                    ),
                    child: TextButton(
                      onPressed: () {
                        AuthService().signInWithGoogle();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeView(),
                          ),
                        );
                      },
                      child: Image.asset(
                        "assets/google.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color.fromARGB(255, 208, 208, 208),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // TODO: Implement Apple Sign In
                      },
                      child: Image.asset(
                        "assets/apple.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    //SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signin()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          style:
                              TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
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
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
