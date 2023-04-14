import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesgpt/net/auth_service.dart';
import 'package:notesgpt/ui/edit_profile_view.dart';
import 'package:notesgpt/ui/home_view.dart';
import 'package:notesgpt/ui/manage_subscription_view.dart';
import 'package:notesgpt/ui/welcome_screen.dart';
import 'package:get/get.dart';

import '../chatgpt/chatpage.dart';
import 'navigation_bar.dart';
import 'notes_library.dart';

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

  Future<void> _changePasswordDialog(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    String? _currentPassword;
    String? _newPassword;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Current Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _currentPassword = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newPassword = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  try {
                    final currentCredential = EmailAuthProvider.credential(
                        email: _user.email!, password: _currentPassword!);
                    await _user.reauthenticateWithCredential(currentCredential);
                    await _user.updatePassword(_newPassword!);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password updated successfully.'),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.message}'),
                      ),
                    );
                  }
                }
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
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
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
          ),
        ),
        title: Text('Settings'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                '${'Hello, '.tr}$_displayName!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(thickness: 1, height: 30),
              buildSettingItem(
                leading: Icon(Icons.person),
                title: 'Edit Profile'.tr,
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
              buildSettingItem(
                leading: Icon(Icons.lock),
                title: 'Change Password'.tr,
                onTap: () {
                  _changePasswordDialog(context);
                },
              ),
              buildSettingItem(
                leading: Icon(Icons.language),
                title: 'Change Language'.tr,
                onTap: () {
                  builddialog(context);
                },
              ),
              buildSettingItem(
                leading: Icon(Icons.account_balance_wallet),
                title: 'Manage Subscription'.tr,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ManageSubscriptionScreen())),
                  );
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  child: Text('Sign Out'.tr),
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
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 3,
        onTabChange: (index) {
          // ChatBot Page
          if (index == 2) {
            // Assuming ChatBot button is at index 2
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(),
              ),
            );
          }
          // Notes Library Page
          else if (index == 1) {
            // Assuming Notes Library button is at index 1
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotesLibrary(),
              ),
            );
          }
          // Profile Page
          else if (index == 3) {
            // Assuming Profile button is at index 3
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserSettingsView(),
              ),
            );
          }
          // Home Page
          else {
            // Assuming Home button is at index 0
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeView(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildSettingItem(
      {required Widget leading,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8),
      leading: leading,
      title: Text(title),
      onTap: onTap,
    );
  }
}
