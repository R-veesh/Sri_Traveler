// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    bool isPress = true;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight - 40 - 150 - 140;
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 40),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/travel.png',
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                width: double.infinity,
                height: containerHeight,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(209, 221, 35, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'User Name',
                          hintText: 'example@gamil.com',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(96, 31, 21, 182),
                          ),
                          prefixIcon: Icon(Icons.supervised_user_circle,
                              color: Color.fromARGB(255, 9, 106, 109)),
                          filled: true,
                          fillColor: Color.fromRGBO(244, 255, 94, 1),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 20, 35, 0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'At Least 8 characters',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(96, 31, 21, 182),
                          ),
                          prefixIcon: Icon(Icons.password_rounded,
                              color: Color.fromARGB(255, 9, 106, 109)),
                          filled: true,
                          fillColor: Color.fromRGBO(244, 255, 94, 1),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.restorablePushNamedAndRemoveUntil(
                              context, "/home", (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                          //: Color.fromRGBO(0, 0, 0, 1),
                          shadowColor: Color.fromRGBO(0, 0, 0, 1),
                        ),
                        child: Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//git 20
