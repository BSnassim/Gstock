import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/Membres/list_membres.dart';
import 'pages/menu.dart';
import 'pages/Categories/list_categories.dart';
import 'pages/Emprunt/list_emprunts.dart';
import 'pages/Retour/list_retours.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'menu': (context) => Menu(),
      'memberlist': (context) => MemberList(),
      'categorylist': (context) => CategoryList(),
    },
  ));
}
