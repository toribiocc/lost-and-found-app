import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 3),
          () {

        Navigator.pushReplacementNamed(
          context,
          '/login',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      Color(0xFFFFFFE3),

      body: Center(

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Image.asset(
              'assets/lost-and-found.png',

              height: 180,
            ),

            SizedBox(height: 25),

            Text(
              'Lost & Found',

              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 1,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Bring back what is lost.',

              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                letterSpacing: 0.5,
              ),
            ),

            SizedBox(height: 50),

            SizedBox(
              width: 28,
              height: 28,

              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}