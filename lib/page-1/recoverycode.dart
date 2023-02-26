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
        // recoverycodeFaV (3:280)
        padding: EdgeInsets.fromLTRB(35*fem, 49*fem, 36*fem, 9*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(20*fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogrouprzc1JYm (LUKnUEBei5VqjwaT7KRZc1)
              margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 72*fem, 56*fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // iconbXs (3:207)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 15.59*fem, 1.41*fem),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom (
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: 18.41*fem,
                        height: 17.41*fem,
                        child: Image.asset(
                          'assets/page-1/images/icon-A5T.png',
                          width: 18.41*fem,
                          height: 17.41*fem,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    // recoverycodedzM (3:206)
                    'Recovery code',
                    style: SafeGoogleFont (
                      'Montserrat',
                      fontSize: 26*ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2175*ffem/fem,
                      color: Color(0xff3e4958),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // therecoverycodewassenttoyourmo (3:208)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 55*fem, 69*fem),
              constraints: BoxConstraints (
                maxWidth: 247*fem,
              ),
              child: Text(
                'The recovery code was sent to your mobile phone. Code expiration time is 120s.\nPlease enter the code:',
                style: SafeGoogleFont (
                  'Roboto',
                  fontSize: 13*ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.8461538462*ffem/fem,
                  color: Color(0xff3e4958),
                ),
              ),
            ),
            Container(
              // group79jg1 (3:209)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 320*fem),
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(14*fem),
              ),
              child: TextField(
                decoration: InputDecoration (
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              // signinCZb (3:214)
              margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 24*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: 303*fem,
                  height: 60*fem,
                  decoration: BoxDecoration (
                    color: Color(0xff1152fd),
                    borderRadius: BorderRadius.circular(14*fem),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
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
              // didntreceiveacodesendagainZYZ (3:218)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6*fem, 39*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: RichText(
                  text: TextSpan(
                    style: SafeGoogleFont (
                      'Montserrat',
                      fontSize: 14*ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.2175*ffem/fem,
                      color: Color(0xff3e4958),
                    ),
                    children: [
                      TextSpan(
                        text: 'Didn’t receive a code',
                      ),
                      TextSpan(
                        text: '? ',
                        style: SafeGoogleFont (
                          'Montserrat',
                          fontSize: 14*ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.2175*ffem/fem,
                          color: Color(0xff3e4958),
                        ),
                      ),
                      TextSpan(
                        text: 'Send again',
                        style: SafeGoogleFont (
                          'Montserrat',
                          fontSize: 14*ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.2175*ffem/fem,
                          color: Color(0xff3e4958),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              // rectangle111r3o (3:205)
              margin: EdgeInsets.fromLTRB(87*fem, 0*fem, 87*fem, 0*fem),
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