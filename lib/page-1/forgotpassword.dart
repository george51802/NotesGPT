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
        // forgotpasswordMQh (3:176)
        padding: EdgeInsets.fromLTRB(36*fem, 49*fem, 36*fem, 9*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(20*fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogrouprx17VfK (LUKmtpydv4o6pPX7v8RX17)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 43*fem, 57*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // icon9zm (3:179)
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
                              'assets/page-1/images/icon-4x5.png',
                              width: 18.41*fem,
                              height: 17.41*fem,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        // forgotpasswordCi9 (3:178)
                        'Forgot password',
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
              ),
            ),
            Container(
              // selectwhichcontactdetailsshoul (3:180)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 87*fem, 54*fem),
              constraints: BoxConstraints (
                maxWidth: 204*fem,
              ),
              child: Text(
                'Select which contact details should\nwe use to reset your password:',
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
              // group39g13 (3:181)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 28*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(6*fem, 6*fem, 99*fem, 6*fem),
                  width: double.infinity,
                  height: 112*fem,
                  decoration: BoxDecoration (
                    border: Border.all(color: Color(0xffd5dde0)),
                    borderRadius: BorderRadius.circular(14*fem),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // group2953B (3:183)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 23.41*fem, 0*fem),
                        padding: EdgeInsets.fromLTRB(32*fem, 36*fem, 32.29*fem, 35.7*fem),
                        height: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xffd5dde0)),
                          borderRadius: BorderRadius.circular(7.4074072838*fem),
                        ),
                        child: Center(
                          // iconKiD (3:201)
                          child: SizedBox(
                            width: 28.3*fem,
                            height: 28.3*fem,
                            child: Image.asset(
                              'assets/page-1/images/icon-Snq.png',
                              width: 28.3*fem,
                              height: 28.3*fem,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // group33QUm (3:185)
                        margin: EdgeInsets.fromLTRB(0*fem, 30*fem, 0*fem, 29*fem),
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // viasmsVm7 (3:187)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                              child: Text(
                                'via sms:',
                                style: SafeGoogleFont (
                                  'Montserrat',
                                  fontSize: 14*ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2175*ffem/fem,
                                  color: Color(0xff3e4958),
                                ),
                              ),
                            ),
                            Text(
                              // Npu (3:186)
                              '*** *******61',
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
                    ],
                  ),
                ),
              ),
            ),
            Container(
              // group775DX (3:188)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 307*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(6*fem, 6*fem, 26*fem, 6*fem),
                  width: double.infinity,
                  height: 112*fem,
                  decoration: BoxDecoration (
                    border: Border.all(color: Color(0xffd5dde0)),
                    borderRadius: BorderRadius.circular(14*fem),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // group294bF (3:190)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 23.41*fem, 0*fem),
                        padding: EdgeInsets.fromLTRB(29*fem, 36*fem, 29.16*fem, 35.83*fem),
                        height: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xffd5dde0)),
                          borderRadius: BorderRadius.circular(7.4074072838*fem),
                        ),
                        child: Center(
                          // icon7ZX (3:196)
                          child: SizedBox(
                            width: 34.43*fem,
                            height: 28.17*fem,
                            child: Image.asset(
                              'assets/page-1/images/icon-PXB.png',
                              width: 34.43*fem,
                              height: 28.17*fem,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // group33ox9 (3:192)
                        margin: EdgeInsets.fromLTRB(0*fem, 30*fem, 0*fem, 29*fem),
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // viaemailWbf (3:194)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                              child: Text(
                                'via email:',
                                style: SafeGoogleFont (
                                  'Montserrat',
                                  fontSize: 14*ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2175*ffem/fem,
                                  color: Color(0xff3e4958),
                                ),
                              ),
                            ),
                            Text(
                              // schgmailcomabX (3:193)
                              '******sch@gmail.com',
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
                    ],
                  ),
                ),
              ),
            ),
            Container(
              // rectangle110guT (3:195)
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