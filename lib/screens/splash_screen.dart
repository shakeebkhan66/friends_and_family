import 'dart:async';

import 'package:flutter/material.dart';
import 'package:friends_and_family/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (ctx)=> SignInScreen())));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  "assets/gif/fnf.gif",
                  fit: BoxFit.fitHeight,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
