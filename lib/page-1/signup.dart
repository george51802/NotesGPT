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
        // signupRD7 (2:115)
        padding: EdgeInsets.fromLTRB(36*fem, 60*fem, 35*fem, 41*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(20*fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogrouphu4h3EV (LUKkdSvEunnh6fjBbmHu4H)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 164*fem, 54*fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // iconX9f (2:153)
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
                          'assets/page-1/images/icon.png',
                          width: 18.41*fem,
                          height: 17.41*fem,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    // signup8v9 (2:152)
                    'Sign Up',
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
              // emailnamecaR (2:147)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 20*fem),
              width: 303*fem,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(14*fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // nameV8R (2:148)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                    child: Text(
                      'Name',
                      style: SafeGoogleFont (
                        'Montserrat',
                        fontSize: 14*ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2175*ffem/fem,
                        color: Color(0xff3e4958),
                      ),
                    ),
                  ),
                  Container(
                    // group9xGu (2:149)
                    padding: EdgeInsets.fromLTRB(17*fem, 21*fem, 17*fem, 21*fem),
                    width: double.infinity,
                    decoration: BoxDecoration (
                      border: Border.all(color: Color(0xffd5dde0)),
                      color: Color(0xfff7f8f9),
                      borderRadius: BorderRadius.circular(14*fem),
                    ),
                    child: Text(
                      'John Doe',
                      style: SafeGoogleFont (
                        'Montserrat',
                        fontSize: 14*ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2175*ffem/fem,
                        color: Color(0xffd5dde0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // emailAds (2:142)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 20*fem),
              width: 303*fem,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(14*fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // emailS5b (2:143)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                    child: Text(
                      'E-mail',
                      style: SafeGoogleFont (
                        'Montserrat',
                        fontSize: 14*ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2175*ffem/fem,
                        color: Color(0xff3e4958),
                      ),
                    ),
                  ),
                  Container(
                    // group9uE5 (2:144)
                    padding: EdgeInsets.fromLTRB(17*fem, 21*fem, 17*fem, 21*fem),
                    width: double.infinity,
                    decoration: BoxDecoration (
                      border: Border.all(color: Color(0xffd5dde0)),
                      color: Color(0xfff7f8f9),
                      borderRadius: BorderRadius.circular(14*fem),
                    ),
                    child: Text(
                      'example@gmail.com',
                      style: SafeGoogleFont (
                        'Montserrat',
                        fontSize: 14*ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2175*ffem/fem,
                        color: Color(0xffd5dde0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // passwordhfj (2:131)
              margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 44*fem),
              width: 303*fem,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // passwordPYZ (2:132)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                    child: Text(
                      'Password',
                      style: SafeGoogleFont (
                        'Montserrat',
                        fontSize: 14*ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2175*ffem/fem,
                        color: Color(0xff3e4958),
                      ),
                    ),
                  ),
                  Container(
                    // group11fFB (2:133)
                    padding: EdgeInsets.fromLTRB(17*fem, 22*fem, 18*fem, 20*fem),
                    width: double.infinity,
                    decoration: BoxDecoration (
                      border: Border.all(color: Color(0xffd5dde0)),
                      color: Color(0xfff7f8f9),
                      borderRadius: BorderRadius.circular(14*fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // Vk1 (2:135)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 192*fem, 0*fem),
                          child: TextField(
                            obscureText: true,
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
                          // iconBMw (2:136)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1.73*fem),
                          width: 17*fem,
                          height: 16.27*fem,
                          decoration: BoxDecoration (
                            color: Color(0xffd5dde0),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // signup2dT (2:117)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 50*fem),
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
                      'Sign Up',
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
              // group7N53 (2:121)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 2*fem, 27*fem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // rectangle584Tf (2:124)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                    width: 90*fem,
                    height: 1*fem,
                    decoration: BoxDecoration (
                      color: Color(0xffd5dde0),
                    ),
                  ),
                  SizedBox(
                    width: 5*fem,
                  ),
                  Text(
                    // orsignupwithLAH (2:122)
                    'Or sign up with',
                    style: SafeGoogleFont (
                      'Montserrat',
                      fontSize: 14*ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2175*ffem/fem,
                      color: Color(0xff3e4958),
                    ),
                  ),
                  SizedBox(
                    width: 5*fem,
                  ),
                  Container(
                    // rectangle57opZ (2:123)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                    width: 90*fem,
                    height: 1*fem,
                    decoration: BoxDecoration (
                      color: Color(0xffd5dde0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // autogroupiwwmUvh (LUKktGpsRUJCi9zFvciwWm)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 50*fem),
              width: double.infinity,
              height: 60*fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // fbZSM (2:128)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 19*fem, 0*fem),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom (
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(58.8*fem, 16*fem, 60.06*fem, 16.09*fem),
                        height: double.infinity,
                        decoration: BoxDecoration (
                          color: Color(0xffd5dde0),
                          borderRadius: BorderRadius.circular(14*fem),
                        ),
                        child: Center(
                          // socialiconappleacM (2:130)
                          child: SizedBox(
                            width: 23.14*fem,
                            height: 27.91*fem,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom (
                                padding: EdgeInsets.zero,
                              ),
                              child: Image.asset(
                                'assets/page-1/images/social-icon-apple.png',
                                width: 23.14*fem,
                                height: 27.91*fem,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    // gmailq2V (2:125)
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(57*fem, 16*fem, 56.67*fem, 15.67*fem),
                      height: double.infinity,
                      decoration: BoxDecoration (
                        color: Color(0xffd5dde0),
                        borderRadius: BorderRadius.circular(14*fem),
                      ),
                      child: Center(
                        // vectorHfB (2:127)
                        child: SizedBox(
                          width: 28.33*fem,
                          height: 28.33*fem,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom (
                              padding: EdgeInsets.zero,
                            ),
                            child: Image.asset(
                              'assets/page-1/images/vector-GFw.png',
                              width: 28.33*fem,
                              height: 28.33*fem,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // alreadyhaveanaccountsigninZch (2:120)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 0*fem),
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
                        text: 'Already have',
                      ),
                      TextSpan(
                        text: ' an account? ',
                        style: SafeGoogleFont (
                          'Montserrat',
                          fontSize: 14*ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.2175*ffem/fem,
                          color: Color(0xff3e4958),
                        ),
                      ),
                      TextSpan(
                        text: 'Sign In',
                        style: SafeGoogleFont (
                          'Montserrat',
                          fontSize: 14*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2175*ffem/fem,
                          color: Color(0xff3e4958),
                        ),
                      ),
                    ],
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