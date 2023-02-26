import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';

class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // passwordresetsuccessfulug9 (3:250)
        padding: EdgeInsets.fromLTRB(36*fem, 262*fem, 36*fem, 9*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(20*fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // group80YDK (3:258)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16.96*fem, 21*fem),
              width: 172.5*fem,
              height: 119*fem,
              child: Image.asset(
                'assets/page-1/images/group-80.png',
                width: 172.5*fem,
                height: 119*fem,
              ),
            ),
            Container(
              // passwordchangedzb7 (3:256)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 21*fem),
              child: Text(
                'Password Changed!',
                textAlign: TextAlign.center,
                style: SafeGoogleFont (
                  'Montserrat',
                  fontSize: 18*ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.2175*ffem/fem,
                  color: Color(0xff3e4958),
                ),
              ),
            ),
            Container(
              // youhavesuccessfullyresetyourpa (3:266)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 206*fem),
              constraints: BoxConstraints (
                maxWidth: 192*fem,
              ),
              child: Text(
                'You have successfully reset your \npassword. Please use your new\npassword when logging in.',
                textAlign: TextAlign.center,
                style: SafeGoogleFont (
                  'Roboto',
                  fontSize: 13*ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.1725*ffem/fem,
                  color: Color(0xff3e4958),
                ),
              ),
            ),
            Container(
              // loginnfP (3:252)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 42*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: double.infinity,
                  height: 60*fem,
                  decoration: BoxDecoration (
                    color: Color(0xff1152fd),
                    borderRadius: BorderRadius.circular(14*fem),
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: SafeGoogleFont (
                        'Montserrat',
                        fontSize: 16*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.2175*ffem/fem,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // rectangle114L4d (3:255)
              margin: EdgeInsets.fromLTRB(86*fem, 0*fem, 87*fem, 0*fem),
              width: double.infinity,
              height: 4*fem,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(3*fem),
                color: Color(0xffd5dde0),
              ),
            ),
          ],
        ),
      ),
          );
  }
}