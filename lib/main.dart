import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:notesgpt/chatgpt/chatpage.dart';
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
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'net/app_camera_controller.dart';

Future<void> main() async {
  Stripe.publishableKey =
      'pk_live_51MbwIXL6VtnCHyTVWrpSlIZAwpEDJUgdLyWtsjcKiNxcq6QWxjre05cIqkefVe6Mk2Y1BlqBHidWCENU4TVg7fS1001t8yWrip';
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put<AppCameraController>(AppCameraController());

  Get.put(HomeView());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConversationProvider()),
      ],
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
      home: AuthService()
          .handleAuthState(), // Update to use HomeView instead of WelcomeScreen
      routes: {
        '/settings': (context) => UserSettingsView(),
        '/chat': (context) => ChatBotRunner(),
      },
    );
  }
}
