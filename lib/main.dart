import 'package:flutter/material.dart';
import 'package:gstock/pages/login.dart';
import 'package:gstock/pages/register.dart';
import 'package:gstock/pages/Membres/list_membres.dart';
import 'package:gstock/pages/menu.dart';
import 'package:gstock/pages/Categories/list_categories.dart';
import 'package:gstock/pages/Composants/list_composants.dart';
import 'package:gstock/pages/Emprunt/list_emprunts.dart';
import 'package:gstock/pages/Retour/list_retours.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'menu': (context) => Menu(),
      'memberlist':(context) => MemberList(),
    },
  ));
}