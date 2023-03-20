import 'package:firebase_auth/firebase_auth.dart';
import 'package:notesgpt/net/auth_service.dart';
import 'package:notesgpt/net/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:notesgpt/net/snackbars.dart';
import 'package:notesgpt/ui/user_sign_in.dart';
import 'package:get/get.dart';
import 'home_view.dart';
import 'welcome_screen.dart';

class UserSignUp extends StatefulWidget {
  UserSignUp({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<UserSignUp> {
  TextEditingController _nameField = TextEditingController();
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _confirmField = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool passwordsMatch = false;

  // Inside a function that is called when the user confirms their password
  void verifyPassword() {
    if (_passwordField.text == _confirmField.text) {
      // Passwords match, set passwordsMatch to true
      setState(() {
        passwordsMatch = true;
      });
    } else {
      // Passwords do not match, set passwordsMatch to false
      setState(() {
        passwordsMatch = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Image.asset(
          'assets/signup.png',
          height: 400,
          fit: BoxFit.cover,
        ),
        toolbarHeight: 210,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Colors.white,
            ),
            height: 30.0,
          ),
        ),
      ),
      body: Form(
        key: _key,
        child: Container(
          //width: double.infinity,
          //height: MediaQuery.of(context).size.height / 1.3,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "createAccount".tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 330,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 255, 255, 255), // light gray background
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
                      validator: validateEmail,
                      decoration: InputDecoration(
                        hintText: "email".tr,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 145, 145,
                                145)), // set hint text color to gray
                        contentPadding:
                            EdgeInsets.fromLTRB(18.0, 5.0, 0.0, 0.0),
                        border: InputBorder.none, // remove underline
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 330,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 255, 255, 255), // light gray background
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
                      validator: validatePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "password".tr,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 145, 145,
                                145)), // set hint text color to gray
                        contentPadding:
                            EdgeInsets.fromLTRB(18.0, 5.0, 0.0, 0.0),
                        border: InputBorder.none, // remove underline
                      ),
                      onChanged: (value) {
                        verifyPassword();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 330,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(
                              255, 255, 255, 255), // light gray background
                          border: Border.all(
                            color: Color.fromARGB(
                                255, 221, 221, 221), // gray border
                          ),
                          borderRadius:
                              BorderRadius.circular(18.0), // border radius
                        ),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          controller: _confirmField,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'confirmPasswordMessage'.tr;
                            } else if (value != _passwordField.text) {
                              passwordsMatch = false;
                              return 'passwordNotMatch'.tr;
                            } else {
                              passwordsMatch = true;
                              return null;
                            }
                          },
                          style: TextStyle(
                              color: Colors.black), // black text color
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "confirmPassword".tr,
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 145, 145,
                                    145)), // set hint text color to gray
                            contentPadding:
                                EdgeInsets.fromLTRB(18.0, 5.0, 0.0, 0.0),
                            border: InputBorder.none, // remove underline
                          ),
                          onChanged: (value) {
                            verifyPassword();
                          },
                        ),
                      ),
                      Positioned(
                        right: 12,
                        top: 15,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: passwordsMatch
                                ? Color(0xff1152FD)
                                : Colors.white,
                            border: Border.all(
                              color: Color.fromARGB(255, 172, 172, 172),
                            ),
                          ),
                          child: passwordsMatch
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15,
                                )
                              : Icon(
                                  Icons.clear,
                                  color: Color(0xff1152FD),
                                  size: 15,
                                ),
                        ),
                      ),
                    ],
                  )
                ],
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
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      ScaffoldMessengerState scaffoldMessenger =
                          ScaffoldMessenger.of(context);
                      bool shouldNavigate = false;
                      String errorMessage = '';
                      try {
                        shouldNavigate = await register(
                            _emailField.text, _passwordField.text);
                      } on RegistrationException catch (e) {
                        errorMessage = e.message;
                      }
                      if (errorMessage.isNotEmpty) {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text(
                              errorMessage,
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
                      } else if (shouldNavigate) {
                        scaffoldMessenger
                            .showSnackBar(
                              SnackBar(
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Color(0xff1152FD)),
                                        backgroundColor: Colors.white,
                                        strokeWidth: 3.0,
                                      ),
                                    ),
                                    Text('',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                backgroundColor: Color(0xff1152FD),
                                behavior: SnackBarBehavior.floating,
                                width: 50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            )
                            .closed
                            .then((SnackBarClosedReason reason) async {
                          if (shouldNavigate) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeView(),
                              ),
                            );
                            scaffoldMessenger.hideCurrentSnackBar();
                          }
                        });
                      }
                    }
                  },
                  child: Text("signUp".tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 0),
              Container(
                margin: EdgeInsets.symmetric(vertical: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.3,
                      ),
                    ),
                    SizedBox(width: 30),
                    Text("orSignUpWith".tr),
                    SizedBox(width: 30),
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
                    width: MediaQuery.of(context).size.width / 3.4,
                    height: 55,
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
                        height: 23,
                        width: 23,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: MediaQuery.of(context).size.width / 3.4,
                    height: 55,
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
                        height: 23,
                        width: 23,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
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
                          MaterialPageRoute(builder: (context) => UserSignIn()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          style:
                              TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
                          children: [
                            TextSpan(
                              text: "alreadyHaveAccount".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 153, 153, 153)),
                            ),
                            TextSpan(
                              text: "signIn".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1152FD)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'emailRequired'.tr;
  }
  if (formEmail != null && !formEmail.contains('@')) {
    return 'emailInvalid'.tr;
  }
  if (formEmail != null && !formEmail.contains('.')) {
    return 'email.Invalid'.tr;
  }
  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'passwordRequired'.tr;
  }
  // if (formPassword.length < 4) {
  //   return 'Password must be at least 4 characters.';
  // }
  // if (formPassword.length > 20) {
  //   return 'Password must be less than 20 characters.';
  // }
  return null;
}

String? validateName(String? formName) {
  if (formName == null || formName.isEmpty) {
    return 'nameRequired'.tr;
  }
  return null;
}
