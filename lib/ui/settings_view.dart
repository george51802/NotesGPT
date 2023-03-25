import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesgpt/net/auth_service.dart';
import 'package:notesgpt/ui/edit_profile_view.dart';
import 'package:notesgpt/ui/manage_subscription_view.dart';
import 'package:notesgpt/ui/welcome_screen.dart';
import 'package:get/get.dart';

class UserSettingsView extends StatefulWidget {
  @override
  _UserSettingsViewState createState() => _UserSettingsViewState();
}

class _UserSettingsViewState extends State<UserSettingsView> {
  final authService = AuthService();

  late User _user;
  late String _displayName;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _displayName = _user.displayName ?? 'User';
  }

  updateName(String name) {
    setState(() {
      _displayName = name;
    });
  }

  final List locale = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
    {'name': 'Español', 'locale': Locale('es', 'SP')}
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  builddialog(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'User';
    final displayName = user?.displayName ?? 'User';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1152FD),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('settings'.tr),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${'hello'.tr}$_displayName!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(thickness: 1, height: 30),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('editProfile'.tr),
            onTap: () async {
              final newName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    currentName: _displayName,
                  ),
                ),
              );
              if (newName != null) {
                updateName(newName);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('changePassword'.tr),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('changeLanguage'.tr),
            onTap: () {
              builddialog(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('changeModel'.tr),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('Manage Subscription'.tr),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => ManageSubscriptionScreen())),
              );
            },
          ),
          Expanded(child: Container()),
          Center(
            child: Container(
              margin: EdgeInsets.all(40),
              child: ElevatedButton(
                child: Text('signOut'.tr),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff1152FD), // Change the color here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                ),
                onPressed: () {
                  authService.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => WelcomeScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
