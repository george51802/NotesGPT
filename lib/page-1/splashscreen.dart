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
        // splashscreenKQ1 (1:2)
        padding: EdgeInsets.fromLTRB(35*fem, 305*fem, 37*fem, 55*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xff1152fd),
          borderRadius: BorderRadius.circular(20*fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroup1ynq5R7 (LUKicWH6VX2G52Z7Tq1YNq)
              margin: EdgeInsets.fromLTRB(71*fem, 0*fem, 68.94*fem, 204*fem),
              width: double.infinity,
              height: 148*fem,
              child: Stack(
                children: [
                  Positioned(
                    // noteslogoapp011iU5 (2:13)
                    left: 40*fem,
                    top: 0*fem,
                    child: Align(
                      child: SizedBox(
                        width: 83*fem,
                        height: 101*fem,
                        child: Image.asset(
                          'assets/page-1/images/noteslogoapp-01-1-zG5.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // group2ZDo (2:18)
                    left: 0*fem,
                    top: 88*fem,
                    child: Container(
                      width: 163.06*fem,
                      height: 60*fem,
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(25*fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // notesn6Z (1:7)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 3*fem, 0*fem),
                            child: Text(
                              'notes',
                              style: SafeGoogleFont (
                                'Poppins',
                                fontSize: 40*ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.5*ffem/fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                          Container(
                            // group1Un1 (2:17)
                            margin: EdgeInsets.fromLTRB(0*fem, 21*fem, 0*fem, 11.93*fem),
                            width: 47.06*fem,
                            height: double.infinity,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(25*fem),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  // rectangle53jT3 (2:15)
                                  left: 0*fem,
                                  top: 0*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 47*fem,
                                      height: 24*fem,
                                      child: Container(
                                        decoration: BoxDecoration (
                                          borderRadius: BorderRadius.circular(25*fem),
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // gptaCm (2:16)
                                  left: 7*fem,
                                  top: 0*fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 32*fem,
                                      height: 24*fem,
                                      child: Text(
                                        'GPT',
                                        style: SafeGoogleFont (
                                          'Poppins',
                                          fontSize: 16*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.5*ffem/fem,
                                          color: Color(0xff1152fd),
                                        ),
                                      ),
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
                ],
              ),
            ),
            Container(
              // signup1Yy (1:4)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 20*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(118.45*fem, 23.41*fem, 120.05*fem, 20.77*fem),
                  width: double.infinity,
                  decoration: BoxDecoration (
                    image: DecorationImage (
                      fit: BoxFit.cover,
                      image: AssetImage (
                        'assets/page-1/images/rectangle-52.png',
                      ),
                    ),
                  ),
                  child: Center(
                    // signupBbs (26:6)
                    child: SizedBox(
                      width: 64.5*fem,
                      height: 15.82*fem,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom (
                          padding: EdgeInsets.zero,
                        ),
                        child: Image.asset(
                          'assets/page-1/images/sign-up.png',
                          width: 64.5*fem,
                          height: 15.82*fem,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // signinqAd (2:14)
              margin: EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 0*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Sign In',
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
          ],
        ),
      ),
          );
  }
}