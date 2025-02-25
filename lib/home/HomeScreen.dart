import 'package:flutter/material.dart';
import 'package:sri_traveler/home/profile/user_references.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final int currentHour = DateTime.now().hour;
    final User = UserReferences.myUser;

    String greetingMessage;
    if (currentHour < 12) {
      greetingMessage = "Good Morning";
    } else if (currentHour < 17) {
      greetingMessage = "Good Afternoon";
    } else {
      greetingMessage = "Good Evening";
    }

    return Scaffold(
      extendBody: true,
      body: Container(
        color: const Color.fromARGB(255, 236, 236, 189),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greetingMessage,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w300,
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                          Text(
                            User.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(User.imagePath),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
