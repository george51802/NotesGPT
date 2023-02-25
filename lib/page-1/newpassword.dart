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
        // newpasswordo4q (3:219)
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
              // autogroupkerzFBj (LUKnzdUfHa41Jdc34vKErZ)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 72*fem, 43*fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // iconLU5 (3:235)
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
                          'assets/page-1/images/icon-C9B.png',
                          width: 18.41*fem,
                          height: 17.41*fem,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    // newpasswordZLq (3:234)
                    'New password',
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
              // yournewpasswordmustbedifferent (3:236)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 87*fem, 35*fem),
              constraints: BoxConstraints (
                maxWidth: 216*fem,
              ),
              child: Text(
                'Your new password must be different\nfrom your previous password.',
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
              // newpasswordUMK (3:229)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 36*fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // newpasswordBWd (3:230)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                    child: Text(
                      'New password',
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
                    // group9rsf (3:231)
                    padding: EdgeInsets.fromLTRB(17*fem, 21*fem, 17*fem, 21*fem),
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
                          // vcd (3:233)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 193*fem, 0*fem),
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
                          // iconcVT (3:243)
                          margin: EdgeInsets.fromLTRB(0*fem, 0.27*fem, 0*fem, 0*fem),
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
              // confirmpasswordfCq (3:224)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 282*fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // confirmpasswordZZ7 (3:225)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                    child: Text(
                      'Confirm password ',
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
                    // group11dYy (3:226)
                    padding: EdgeInsets.fromLTRB(17*fem, 22*fem, 17*fem, 20*fem),
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
                          // tjo (3:228)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 193*fem, 0*fem),
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
                          // iconbu7 (3:237)
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
              // updategvZ (3:221)
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
                      'Update',
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
              // rectangle113gp5 (3:249)
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