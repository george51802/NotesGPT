import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:notesgpt/chatgpt/chat_runner.dart';
import 'package:notesgpt/chatgpt/chatpage.dart';
import 'package:notesgpt/ui/settings_view.dart';
import 'package:notesgpt/ui/transcription_view.dart';
import '../chatgpt/models.dart';
import 'navigation_bar.dart';
import 'notes_library.dart';
import 'package:notesgpt/net/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:notesgpt/chatgpt/conversation_provider.dart';
import 'package:google_fonts/google_fonts.dart';


class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375.0000610352;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // althomeiPD (152:5)
        width: double.infinity,
        height: 812*fem,
        child: Stack(
          children: [
            Positioned(
              // bgZej (152:6)
              left: 0.0000305176*fem,
              top: 26*fem,
              child: Align(
                child: SizedBox(
                  width: 375*fem,
                  height: 728*fem,
                  child: Image.asset(
                    'assets/page-1/images/bg-SzX.png',
                    width: 375*fem,
                    height: 728*fem,
                  ),
                ),
              ),
            ),
            Positioned(
              // bgDjH (152:7)
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
              // rectangle52HUF (152:8)
              left: 0*fem,
              top: 0*fem,
              child: Align(
                child: SizedBox(
                  width: 375*fem,
                  height: 298*fem,
                  child: Container(
                    decoration: BoxDecoration (
                      border: Border.all(color: Color(0xff000000)),
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
              // group81T1M (152:9)
              left: 36*fem,
              top: 21*fem,
              child: Container(
                width: 175.06*fem,
                height: 58*fem,
                child: Stack(
                  children: [
                    Positioned(
                      // noteslogoapp011X1D (152:10)
                      left: 0*fem,
                      top: 12*fem,
                      child: Align(
                        child: SizedBox(
                          width: 29*fem,
                          height: 35*fem,
                          child: Image.asset(
                            'assets/page-1/images/noteslogoapp-01-1-b4f.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // notesyP1 (152:11)
                      left: 26*fem,
                      top: 0*fem,
                      child: Align(
                        child: SizedBox(
                          width: 99*fem,
                          height: 53*fem,
                          child: Text(
                            'notes',
                            style: TextStyle (
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
                      // yournotesinstantlysmarterPBq (152:12)
                      left: 23*fem,
                      top: 43*fem,
                      child: Align(
                        child: SizedBox(
                          width: 145*fem,
                          height: 15*fem,
                          child: Text(
                            'Your notes, instantly smarter',
                            style: TextStyle (
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
                      // group1ZkX (152:13)
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
                              // rectangle53ELs (152:14)
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
                              // gptgyZ (152:15)
                              left: 7*fem,
                              top: 0*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 32*fem,
                                  height: 24*fem,
                                  child: Text(
                                    'GPT',
                                    style:TextStyle (
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
              // bgLYK (152:16)
              left: 0.0000305176*fem,
              top: 414*fem,
              child: Align(
                child: SizedBox(
                  width: 375*fem,
                  height: 398*fem,
                  child: Container(
                    decoration: BoxDecoration (
                      border: Border.all(color: Color(0xff000000)),
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
              // searchboxjKZ (152:17)
              left: 36.0000305176*fem,
              top: 103*fem,
              child: Align(
                child: SizedBox(
                  width: 303*fem,
                  height: 71*fem,
                  child: Container(
                    decoration: BoxDecoration (
                      border: Border.all(color: Color(0xff000000)),
                      color: Color(0xfff7f8f9),
                      borderRadius: BorderRadius.circular(14*fem),
                    ),
                    child: TextField(
                      decoration: InputDecoration (
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(24.35*fem, 23.67*fem, 24.35*fem, 24.01*fem),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // rectangle633zT (152:26)
              left: 36.0000305176*fem,
              top: 206*fem,
              child: Align(
                child: SizedBox(
                  width: 303*fem,
                  height: 74*fem,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(19*fem),
                        border: Border.all(color: Color(0xff000000)),
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
              // rectangle64HGX (152:67)
              left: 36*fem,
              top: 317*fem,
              child: Align(
                child: SizedBox(
                  width: 303*fem,
                  height: 74*fem,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(19*fem),
                        border: Border.all(color: Color(0xff000000)),
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
              // startrecordingX4P (152:27)
              left: 59*fem,
              top: 229*fem,
              child: Align(
                child: SizedBox(
                  width: 143*fem,
                  height: 27*fem,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Start Recording',
                      style: TextStyle (
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
              // documentscanningu4w (152:68)
              left: 59*fem,
              top: 340*fem,
              child: Align(
                child: SizedBox(
                  width: 188*fem,
                  height: 27*fem,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Document Scanning',
                      style: TextStyle (
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
              // iconmicrophone2JMy (152:30)
              left: 282*fem,
              top: 229*fem,
              child: Align(
                child: SizedBox(
                  width: 20.73*fem,
                  height: 27.09*fem,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Image.asset(
                      'assets/page-1/images/icon-microphone-2-A4B.png',
                      width: 20.73*fem,
                      height: 27.09*fem,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // boxnHzb (152:37)
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
                  // rectangle65jrb (152:38)
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
              // boxnobZ (152:39)
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
                  // rectangle65qo9 (152:40)
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
              // navbarwLP (152:41)
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
                  // group23YLB (152:43)
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // iconee7 (152:53)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 70.76*fem, 0*fem),
                        width: 24.24*fem,
                        height: 22.26*fem,
                        child: Image.asset(
                          'assets/page-1/images/icon-ctB.png',
                          width: 24.24*fem,
                          height: 22.26*fem,
                        ),
                      ),
                      Container(
                        // iconu4F (152:60)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 69.95*fem, 0.26*fem),
                        width: 24.05*fem,
                        height: 22*fem,
                        child: Image.asset(
                          'assets/page-1/images/icon-uzb.png',
                          width: 24.05*fem,
                          height: 22*fem,
                        ),
                      ),
                      Container(
                        // iconYN7 (152:56)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 70.34*fem, 0.26*fem),
                        width: 21.66*fem,
                        height: 22*fem,
                        child: Image.asset(
                          'assets/page-1/images/icon-5rK.png',
                          width: 21.66*fem,
                          height: 22*fem,
                        ),
                      ),
                      Container(
                        // iconDDM (152:44)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.26*fem),
                        width: 22*fem,
                        height: 22*fem,
                        child: Image.asset(
                          'assets/page-1/images/icon-AaF.png',
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
              // noteslibraryVRm (152:63)
              left: 36.0000305176*fem,
              top: 438*fem,
              child: Align(
                child: SizedBox(
                  width: 123*fem,
                  height: 27*fem,
                  child: Text(
                    'Notes Library',
                    style: TextStyle(
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
              // viewall7CF (152:64)
              left: 266.0000305176*fem,
              top: 431*fem,
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
                    style: TextStyle (
                      fontSize: 12*ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2175*ffem/fem,
                      color: Color(0xffffffff),
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