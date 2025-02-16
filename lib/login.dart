// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app_bra
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(209, 221, 35, 1),
        // title: Text(
        //   "Sri Traveler",
        //   style: TextStyle(
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.black,
        //   ),
        // ),
        // centerTitle: true,
      ),
      //body_part
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(209, 221, 35, 1)),
              ),
            ),
            Container(
              child: Image.network(
                'https://e7.pngegg.com/pngimages/282/992/png-clipart-kandy-sigiriya-negombo-sri-lanka-a-cricket-team-tourradar-coral-reef-geography-landforms-leaf-text.png',
              ),
            ),
            Container(
              //yellow wigit
              margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                color: Color.fromRGBO(209, 221, 35, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              //user name
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 50, 35, 0),
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
                        fillColor: Color.fromRGBO(209, 221, 35, 1),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        signed: true,
                      ),
                    ),
                  ),
                  //password
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 20, 35, 0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'At Least 8 cheaters',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(96, 31, 21, 182),
                        ),
                        prefixIcon: Icon(Icons.password_rounded,
                            color: Color.fromARGB(255, 9, 106, 109)),
                        filled: true,
                        fillColor: Color.fromRGBO(209, 221, 35, 1),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('done');
                        }
                      },
                      child: Text('Login'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
