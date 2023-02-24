import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/splashscreen.dart';
// import 'package:myapp/page-1/signin.dart';
// import 'package:myapp/page-1/signup.dart';
// import 'package:myapp/page-1/forgotpassword.dart';
// import 'package:myapp/page-1/recoverycode.dart';
// import 'package:myapp/page-1/newpassword.dart';
// import 'package:myapp/page-1/passwordresetsuccessful.dart';
// import 'package:myapp/page-1/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
	return MaterialApp(
		title: 'Flutter',
		debugShowCheckedModeBanner: false,
		scrollBehavior: MyCustomScrollBehavior(),
		theme: ThemeData(
		primarySwatch: Colors.blue,
		),
		home: Scaffold(
		body: SingleChildScrollView(
			child: Scene(),
		),
		),
	);
	}
}
