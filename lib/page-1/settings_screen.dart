import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    final List locale = [
      {'name': 'English', 'locale': Locale('en', 'US')},
      {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
      {'name': 'Español', 'locale': Locale('es', 'SP')}
    ];

    updateLanguage(Locale locale) {
      Get.back();
      Get.updateLocale(locale);
    }

    fillerMethod() {
      print('Hello World!');
    }

    buildDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              title: Text('Choose a language'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              print(locale[index]['name']);
                              updateLanguage(locale[index]['locale']);
                            },
                            child: Text(locale[index]['name'])),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.blue,
                      );
                    },
                    itemCount: locale.length),
              ),
            );
          });
    }

    final ButtonStyle myStyle = ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10),
        backgroundColor: Colors.blue,
        fixedSize: Size.fromWidth(200));

    return Container(
        child: Container(
            // recoverycodeFaV (3:280)
            padding: EdgeInsets.fromLTRB(35 * fem, 49 * fem, 36 * fem, 9 * fem),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.circular(20 * fem),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      buildDialog(context);
                    },
                    icon: Icon(Icons.book_online),
                    label: Text('changeLanguage'.tr),
                    style: myStyle,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: fillerMethod,
                    icon: Icon(Icons.door_sliding),
                    label: Text('signOut'.tr),
                    style: myStyle,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: fillerMethod,
                    icon: Icon(Icons.person),
                    label: Text('addFriends'.tr),
                    style: myStyle,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: fillerMethod,
                    icon: Icon(Icons.edit),
                    label: Text('editProfile'.tr),
                    style: myStyle,
                  ),
                ])));
  }
}
