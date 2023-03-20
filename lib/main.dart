import 'package:firebase_core/firebase_core.dart';
import 'package:notesgpt/net/auth_service.dart';
import 'package:notesgpt/ui/home_view.dart'; // import HomeView
import 'package:notesgpt/ui/settings_view.dart';
import 'package:notesgpt/ui/welcome_screen.dart';
import 'chatgpt/chat_runner.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // import Get and HomeController
import 'package:provider/provider.dart';
import 'package:notesgpt/chatgpt/conversation_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(HomeController()); // Register HomeController with Get
  runApp(
    ChangeNotifierProvider(
      create: (_) => ConversationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NotesGPT',
      home: WelcomeScreen(), // Update to use HomeView instead of WelcomeScreen
      routes: {
        '/settings': (context) => UserSettingsView(),
      },
    );
  }
}
