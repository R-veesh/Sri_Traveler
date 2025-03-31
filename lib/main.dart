import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sri_traveler/auth/login_screen.dart';
import 'package:sri_traveler/home.dart';
import 'package:sri_traveler/home/profile/edit_profile_screen.dart';
import 'firebase_options.dart';
import 'Splash_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sri Traveler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(129, 180, 230, 255),
        colorScheme: ColorScheme.light(
          primary: const Color.fromARGB(255, 35, 85, 110),
          secondary: const Color.fromARGB(225, 188, 204, 220),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(129, 180, 230, 255),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(129, 180, 230, 255),
            foregroundColor: Colors.black,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromARGB(129, 180, 230, 255),
            ),
          ),
        ),
      ),
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => homePage(),
        "/edit-profile": (context) => EditProfileScreen(),
      },
    );
  }
}
