import 'package:flutter/material.dart';
import 'package:gstock/pages/login.dart';
import 'package:gstock/pages/register.dart';
import 'package:gstock/pages/splash.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'splash': (context) => SplashScreen(),
    },
  ));
}