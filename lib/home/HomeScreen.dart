import 'package:flutter/material.dart';
import 'package:sri_traveler/home/profile/user_references.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User = UserReferences.myUser;
    return Scaffold(
      extendBody: true,
      body: Container(
        color: Colors.yellowAccent,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Hello,',
                        style: const TextStyle(
                          fontSize: 15,
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
                      const SizedBox(width: 90),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(width: 100),
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
