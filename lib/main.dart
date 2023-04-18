import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // Provide a TickerProvider
      duration: Duration(milliseconds: 500), // Duration of the animation
      upperBound: 1.0, // Upper bound of the opacity
    );
    _animation = Tween<double>(
      begin: 0.0, // Starting opacity value
      end: 1.0, // Ending opacity value
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NotesGPT',
      home: FadeTransition(
        opacity: _animation, // Use the opacity animation
        child: AuthService().handleAuthState(), // Update to use HomeView instead of WelcomeScreen
      ),
      routes: {
        '/settings': (context) => UserSettingsView(),
        '/chat': (context) => ChatBotRunner(),
      },
    );
  }
}
