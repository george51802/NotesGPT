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
        // signin5py (2:74)
        padding: EdgeInsets.fromLTRB(36 * fem, 49 * fem, 36 * fem, 52 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(20 * fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroupfvaui7F (LUKjLejY5iKgHvsCb9fVau)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 175 * fem, 16 * fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // iconQEy (2:102)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 15.59 * fem, 1.41 * fem),
                    child: TextButton(
                      onPressed:() {
                        
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: 18.41 * fem,
                        height: 17.41 * fem,
                        child: Image.asset(
                          'assets/page-1/images/icon-vSR.png',
                          width: 18.41 * fem,
                          height: 17.41 * fem,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    // signincbw (2:101)
                    'Sign In',
                    style: SafeGoogleFont(
                      'Montserrat',
                      fontSize: 26 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2175 * ffem / fem,
                      color: Color(0xff3e4958),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // welcomebacksignintoyournotesac (2:103)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 38 * fem, 47 * fem),
              constraints: BoxConstraints(
                maxWidth: 265 * fem,
              ),
              child: Text(
                'Welcome back! Sign in to your Notes account by entering your email and password below.',
                style: SafeGoogleFont(
                  'Roboto',
                  fontSize: 13 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.8461538462 * ffem / fem,
                  color: Color(0xff3e4958),
                ),
              ),
            ),
            Container(
              // emailtxm (2:96)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 20 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14 * fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // emailaqb (2:97)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                    child: Text(
                      'E-mail',
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 14 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2175 * ffem / fem,
                        color: Color(0xff3e4958),
                      ),
                    ),
                  ),
                  Container(
                    // group9S77 (2:98)
                    padding: EdgeInsets.fromLTRB(
                        17 * fem, 21 * fem, 17 * fem, 21 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffd5dde0)),
                      color: Color(0xfff7f8f9),
                      borderRadius: BorderRadius.circular(14 * fem),
                    ),
                    child: Text(
                      'example@gmail.com',
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 14 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2175 * ffem / fem,
                        color: Color(0xffd5dde0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // passwordptM (2:91)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 23 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14 * fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // passwordueu (2:92)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                    child: Text(
                      'Password',
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 14 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2175 * ffem / fem,
                        color: Color(0xff3e4958),
                      ),
                    ),
                  ),
                  Container(
                    // group11yem (2:93)
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14 * fem),
                      border: Border.all(color: Color(0xffd5dde0)),
                      color: Color(0xfff7f8f9),
                    ),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(
                            17 * fem, 22 * fem, 17 * fem, 20 * fem),
                        hintText: '**********',
                        hintStyle: TextStyle(color: Color(0xffd5dde0)),
                      ),
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 14 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2175 * ffem / fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // autogroupfna18vy (LUKjWjH5REmH5tFBHzFna1)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 48 * fem),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // checkDxR (2:104)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 153 * fem, 0 * fem),
                    width: 22 * fem,
                    height: 22 * fem,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/page-1/images/rectangle-59.png',
                        ),
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    // forgotpassword2us (2:84)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 2 * fem, 0 * fem, 0 * fem),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Forgot password?',
                        style: SafeGoogleFont(
                          'Montserrat',
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff3e4958),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // signinre1 (2:76)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 50 * fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: double.infinity,
                  height: 60 * fem,
                  decoration: BoxDecoration(
                    color: Color(0xff1152fd),
                    borderRadius: BorderRadius.circular(14 * fem),
                  ),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.2175 * ffem / fem,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // group7S6R (2:80)
              margin: EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 27 * fem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // rectangle58KR7 (2:83)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 1 * fem),
                    width: 91 * fem,
                    height: 1 * fem,
                    decoration: BoxDecoration(
                      color: Color(0xffd5dde0),
                    ),
                  ),
                  SizedBox(
                    width: 7 * fem,
                  ),
                  Text(
                    // orsigninwithaM3 (2:81)
                    'Or sign in with',
                    style: SafeGoogleFont(
                      'Montserrat',
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2175 * ffem / fem,
                      color: Color(0xff3e4958),
                    ),
                  ),
                  SizedBox(
                    width: 7 * fem,
                  ),
                  Container(
                    // rectangle57qnm (2:82)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 1 * fem),
                    width: 91 * fem,
                    height: 1 * fem,
                    decoration: BoxDecoration(
                      color: Color(0xffd5dde0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // autogroupcuxdXQh (LUKjgUVqcvk9WBqrJecUxd)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 50 * fem),
              width: double.infinity,
              height: 60 * fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // fbcS9 (2:172)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 19 * fem, 0 * fem),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            58.8 * fem, 16 * fem, 60.06 * fem, 16.09 * fem),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffd5dde0),
                          borderRadius: BorderRadius.circular(14 * fem),
                        ),
                        child: Center(
                          // socialiconappleds3 (2:174)
                          child: SizedBox(
                            width: 23.14 * fem,
                            height: 27.91 * fem,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Image.asset(
                                'assets/page-1/images/social-icon-apple-D7T.png',
                                width: 23.14 * fem,
                                height: 27.91 * fem,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    // gmailU6y (2:85)
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          57 * fem, 16 * fem, 56.67 * fem, 15.67 * fem),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffd5dde0),
                        borderRadius: BorderRadius.circular(14 * fem),
                      ),
                      child: Center(
                        // vectorYsX (2:87)
                        child: SizedBox(
                          width: 28.33 * fem,
                          height: 28.33 * fem,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Image.asset(
                              'assets/page-1/images/vector.png',
                              width: 28.33 * fem,
                              height: 28.33 * fem,
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
              // donthaveanaccountsignupp4M (2:79)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: RichText(
                  text: TextSpan(
                    style: SafeGoogleFont(
                      'Montserrat',
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.2189999989 * ffem / fem,
                      color: Color(0xff3e4958),
                    ),
                    children: [
                      TextSpan(
                        text: 'Don’t have an account? ',
                        style: SafeGoogleFont(
                          'Montserrat',
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff3e4958),
                        ),
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        style: SafeGoogleFont(
                          'Montserrat',
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2175 * ffem / fem,
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
