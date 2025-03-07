import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sri_traveler/auth/login_screen.dart';
// import 'home.dart';

// void main() {
//   runApp(MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

//add things
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //
      // home: homePage(),
      // loginPage()
      // homePage()
      //
      //lihidu
      //
      // routes: {
      //   "/": (context) => loginPage(),
      //   "/home": (context) => homePage(),
      // },
      //
      home: LoginScreen(),
    );
  }
}
