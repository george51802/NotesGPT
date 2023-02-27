import 'package:notesgpt/net/flutterfire.dart';
import 'package:flutter/material.dart';

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
            child: Text("Sign Up",
                style: TextStyle(color: Colors.black, fontSize: 35.0)),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "E-mail",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 244, 244, 244), // light gray background
                      border: Border.all(
                        color:
                            Color.fromARGB(255, 189, 189, 189), // gray border
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
              SizedBox(height: MediaQuery.of(context).size.height / 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Password",
                      style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 244, 244, 244), // light gray background
                      border: Border.all(
                        color:
                            Color.fromARGB(255, 189, 189, 189), // gray border
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
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
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
              SizedBox(height: MediaQuery.of(context).size.height / 35),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate =
                        await signIn(_emailField.text, _passwordField.text);
                    if (shouldNavigate) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeView(),
                        ),
                      );
                    }
                  },
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
