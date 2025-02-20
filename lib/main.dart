import 'package:flutter/material.dart';
import 'package:sri_traveler/login.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: homePage(),
      // loginPage()
      // homePage()
      routes: {
        "/": (context) => loginPage(),
        "/home": (context) => homePage(),
      },
    );
  }
}
// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/material.dart';
// import 'login.dart';

// void main() => runApp(
//       DevicePreview(
//         builder: (context) => MyApp(), // Wrap your app
//       ),
//     );

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       useInheritedMediaQuery: true,
//       locale: DevicePreview.locale(context),
//       builder: DevicePreview.appBuilder,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       home: const loginPage(),
//     );
//   }
// }
