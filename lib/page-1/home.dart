import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';

class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375.0000610352;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // home2Qd (20:109)
        width: double.infinity,
        height: 812*fem,
        child: Stack(
          children: [
            Positioned(
              // bgiYM (20:170)
              left: 0.0000305176*fem,
              top: 26*fem,
              child: Align(
                child: SizedBox(
                  width: 375*fem,
                  height: 728*fem,
                  child: Image.asset(
                    'assets/page-1/images/bg.png',
                    width: 375*fem,
                    height: 728*fem,
                  ),
                ),
              ),
            ),
            Positioned(
              // bgZos (20:171)
              left: 0.0000305176*fem,
              top: 26*fem,
              child: Align(
                child: SizedBox(
                  width: 375*fem,
                  height: 728*fem,
                  child: Container(
                    decoration: BoxDecoration (
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // rectangle52Rr5 (20:172)
              left: 0*fem,
              top: 0*fem,
              child: Align(
                child: SizedBox(
                  width: 375*fem,
                  height: 298*fem,
                  child: Container(
                    decoration: BoxDecoration (
                      color: Color(0xff1152fd),
                      borderRadius: BorderRadius.only (
                        topLeft: Radius.circular(38*fem),
                        topRight: Radius.circular(38*fem),
                        bottomRight: Radius.circular(20*fem),
                        bottomLeft: Radius.circular(20*fem),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // group81Dmw (32:9)
              left: 36*fem,
              top: 21*fem,
              child: Container(
                width: 175.06*fem,
                height: 58*fem,
                child: Stack(
                  children: [
                    Positioned(
                      // noteslogoapp011UC5 (20:173)
                      left: 0*fem,
                      top: 12*fem,
                      child: Align(
                        child: SizedBox(
                          width: 29*fem,
                          height: 35*fem,
                          child: Image.asset(
                            'assets/page-1/images/noteslogoapp-01-1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // notesx7F (20:174)
                      left: 26*fem,
                      top: 0*fem,
                      child: Align(
                        child: SizedBox(
                          width: 99*fem,
                          height: 53*fem,
                          child: Text(
                            'notes',
                            style: SafeGoogleFont (
                              'Poppins',
                              fontSize: 35*ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.5*ffem/fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // yournotesinstantlysmarterPiM (20:175)
                      left: 23*fem,
                      top: 43*fem,
                      child: Align(
                        child: SizedBox(
                          width: 145*fem,
                          height: 15*fem,
                          child: Text(
                            'Your notes, instantly smarter',
                            style: SafeGoogleFont (
                              'Poppins',
                              fontSize: 10*ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.5*ffem/fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // group11zd (20:176)
                      left: 128*fem,
                      top: 16*fem,
                      child: Container(
                        width: 47.06*fem,
                        height: 27.07*fem,
                        decoration: BoxDecoration (
                          borderRadius: BorderRadius.circular(25*fem),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              // rectangle53gqs (20:177)
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
                              // gptxHb (20:178)
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
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // bgRws (20:180)
              left: 0.0000305176*fem,
              top: 414*fem,
              child: Align(
                child: SizedBox(
                  width: 375*fem,
                  height: 398*fem,
                  child: Container(
                    decoration: BoxDecoration (
                      color: Color(0xfff7f8f9),
                      borderRadius: BorderRadius.only (
                        topLeft: Radius.circular(25*fem),
                        topRight: Radius.circular(25*fem),
                        bottomRight: Radius.circular(20*fem),
                        bottomLeft: Radius.circular(20*fem),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // searchbox5Wd (20:189)
              left: 36.0000305176*fem,
              top: 103*fem,
              child: Container(
                padding: EdgeInsets.fromLTRB(18*fem, 20*fem, 18*fem, 20.29*fem),
                width: 224*fem,
                height: 60*fem,
                decoration: BoxDecoration (
                  border: Border.all(color: Color(0xffd5dde0)),
                  color: Color(0xfff7f8f9),
                  borderRadius: BorderRadius.circular(14*fem),
                ),
                child: Container(
                  // searchiJh (32:10)
                  width: 75*fem,
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // iconp6q (20:192)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6.29*fem, 0*fem),
                        width: 19.71*fem,
                        height: 19.71*fem,
                        child: Image.asset(
                          'assets/page-1/images/icon-qxH.png',
                          width: 19.71*fem,
                          height: 19.71*fem,
                        ),
                      ),
                      Container(
                        // searchVim (20:191)
                        margin: EdgeInsets.fromLTRB(0*fem, 0.29*fem, 0*fem, 0*fem),
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
              ),
            ),
            Positioned(
              // rectangle63C7P (20:197)
              left: 36.0000305176*fem,
              top: 206*fem,
              child: Align(
                child: SizedBox(
                  width: 303*fem,
                  height: 140*fem,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(19*fem),
                        color: Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x19232323),
                            offset: Offset(-5*fem, 15*fem),
                            blurRadius: 17.5*fem,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // notebotQDT (20:199)
              left: 148*fem,
              top: 266*fem,
              child: Align(
                child: SizedBox(
                  width: 73*fem,
                  height: 27*fem,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'NoteBot',
                      style: SafeGoogleFont (
                        'Poppins',
                        fontSize: 18*ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.5*ffem/fem,
                        color: Color(0xff3e4958),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // micboxSR3 (32:11)
              left: 279.0000305176*fem,
              top: 103*fem,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20*fem, 18*fem, 19.27*fem, 14.91*fem),
                  width: 60*fem,
                  height: 60*fem,
                  decoration: BoxDecoration (
                    border: Border.all(color: Color(0xffd5dde0)),
                    color: Color(0xfff7f8f9),
                    borderRadius: BorderRadius.circular(14*fem),
                  ),
                  child: Center(
                    // iconmicrophone2twF (20:203)
                    child: SizedBox(
                      width: 20.73*fem,
                      height: 27.09*fem,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom (
                          padding: EdgeInsets.zero,
                        ),
                        child: Image.asset(
                          'assets/page-1/images/icon-microphone-2.png',
                          width: 20.73*fem,
                          height: 27.09*fem,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // boxnXzD (20:210)
              left: 36.0000305176*fem,
              top: 486*fem,
              child: Container(
                width: 140*fem,
                height: 233*fem,
                decoration: BoxDecoration (
                  borderRadius: BorderRadius.circular(16*fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0*fem, 4*fem),
                      blurRadius: 2*fem,
                    ),
                  ],
                ),
                child: Center(
                  // rectangle65NE9 (20:211)
                  child: SizedBox(
                    width: double.infinity,
                    height: 233*fem,
                    child: Container(
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(16*fem),
                        color: Color(0xfffefefe),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // boxnfU9 (32:12)
              left: 196*fem,
              top: 486*fem,
              child: Container(
                width: 140*fem,
                height: 233*fem,
                decoration: BoxDecoration (
                  borderRadius: BorderRadius.circular(16*fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0*fem, 4*fem),
                      blurRadius: 2*fem,
                    ),
                  ],
                ),
                child: Center(
                  // rectangle65L4V (32:13)
                  child: SizedBox(
                    width: double.infinity,
                    height: 233*fem,
                    child: Container(
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(16*fem),
                        color: Color(0xfffefefe),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // navbarS7X (20:214)
              left: 0.0000305176*fem,
              top: 744*fem,
              child: Container(
                padding: EdgeInsets.fromLTRB(36*fem, 23*fem, 36*fem, 22.74*fem),
                width: 375*fem,
                height: 68*fem,
                decoration: BoxDecoration (
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only (
                    topLeft: Radius.circular(20*fem),
                    topRight: Radius.circular(20*fem),
                    bottomRight: Radius.circular(5*fem),
                    bottomLeft: Radius.circular(5*fem),
                  ),
                ),
                child: Container(
                  // group23U4D (20:216)
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // icon9w3 (20:226)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 70.76*fem, 0*fem),
                        width: 24.24*fem,
                        height: 22.26*fem,
                        child: Image.asset(
                          'assets/page-1/images/icon-cy3.png',
                          width: 24.24*fem,
                          height: 22.26*fem,
                        ),
                      ),
                      Container(
                        // iconq3B (20:233)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 69.95*fem, 0.26*fem),
                        width: 24.05*fem,
                        height: 22*fem,
                        child: Image.asset(
                          'assets/page-1/images/icon-KQ9.png',
                          width: 24.05*fem,
                          height: 22*fem,
                        ),
                      ),
                      Container(
                        // icon6jo (20:229)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 70.34*fem, 0.26*fem),
                        width: 21.66*fem,
                        height: 22*fem,
                        child: Image.asset(
                          'assets/page-1/images/icon-rJH.png',
                          width: 21.66*fem,
                          height: 22*fem,
                        ),
                      ),
                      Container(
                        // iconbAm (20:217)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.26*fem),
                        width: 22*fem,
                        height: 22*fem,
                        child: Image.asset(
                          'assets/page-1/images/icon-zNh.png',
                          width: 22*fem,
                          height: 22*fem,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              // noteslibraryUkM (20:198)
              left: 36.0000305176*fem,
              top: 438*fem,
              child: Align(
                child: SizedBox(
                  width: 123*fem,
                  height: 27*fem,
                  child: Text(
                    'Notes Library',
                    style: SafeGoogleFont (
                      'Poppins',
                      fontSize: 18*ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.5*ffem/fem,
                      color: Color(0xff3e4958),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // viewall8a1 (20:200)
              left: 266.0000305176*fem,
              top: 431*fem,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: 73*fem,
                  height: 36*fem,
                  decoration: BoxDecoration (
                    color: Color(0xff1152fd),
                    borderRadius: BorderRadius.circular(7*fem),
                  ),
                  child: Center(
                    child: Text(
                      'View all',
                      style: SafeGoogleFont (
                        'Montserrat',
                        fontSize: 12*ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.2175*ffem/fem,
                        color: Color(0xffffffff),
                      ),
                    ),
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