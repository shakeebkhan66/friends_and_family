import 'package:flutter/material.dart';
import 'package:friends_and_family/screens/home_screen.dart';
import 'package:friends_and_family/screens/splash_screen.dart';
import 'package:friends_and_family/screens/utils/shared_prefrence.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Constants.preferences = await SharedPreferences.getInstance();
  runApp(
      MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "CodeBase Task",
    home: Constants.preferences!.getBool("loggedIn") == true ? HomeScreen() : SplashScreen(),
  ));
}



