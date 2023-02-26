import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/local_string.dart';
import 'package:myapp/utils.dart';
// import 'package:myapp/page-1/splashscreen.dart';
// import 'package:myapp/page-1/signin.dart';
// import 'package:myapp/page-1/signup.dart';
// import 'package:myapp/page-1/forgotpassword.dart';
// import 'package:myapp/page-1/recoverycode.dart';
// import 'package:myapp/page-1/newpassword.dart';
// import 'package:myapp/page-1/passwordresetsuccessful.dart';
// import 'package:myapp/page-1/home.dart';
import 'package:myapp/page-1/settings_screen.dart';

void main() {
  Get.put(Controller());
  runApp(GetMaterialApp(
    home: Home(),
    translations: LocalString(),
    locale: Locale('en', 'US'),
    title: 'Flutter',
    debugShowCheckedModeBanner: false,
    scrollBehavior: MyCustomScrollBehavior(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}

class Controller extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeEndDrawer();
  }
}

class Home extends GetView<Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      key: controller.scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('NotesGPT NavBar'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                controller.closeDrawer;
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Friends'),
              onTap: () {
                controller.closeDrawer;
              },
            ),
            ListTile(
              leading: Icon(Icons.text_decrease),
              title: Text('ChatBot'),
              onTap: () {
                controller.closeDrawer;
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                controller.closeDrawer;
              },
            ),
            ListTile(
              leading: Icon(Icons.door_back_door),
              title: Text('Sign Out'),
              onTap: () {
                controller.closeDrawer;
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Settings(),
      ),
    );
  }
}
