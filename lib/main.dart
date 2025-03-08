import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sri_traveler/Splash_Screen.dart';
import 'package:sri_traveler/auth/login_screen.dart';
import 'package:sri_traveler/home/HomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => SplashScreen(),
        "/login": (context) => LoginScreen(),
        "/home": (context) => HomeScreen(),
      },
    );
  }
}
