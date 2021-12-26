import 'package:flutter/material.dart';
import 'package:gstock/pages/Membres/add_membres.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/Membres/list_membres.dart';
import 'pages/menu.dart';
import 'pages/Categories/list_categories.dart';
import 'pages/Composants/list_composants.dart';
import 'pages/Emprunt/list_emprunts.dart';
import 'pages/Retour/list_retours.dart';
import 'pages/Categories/add_categories.dart';

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
      'componentlist': (context) => ComponentList(),
      'addcateg': (context) => AddCateg(),
      'addmem' : (context) => AddMembre(),
    },
  ));
}
