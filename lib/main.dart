import 'package:flutter/material.dart';
import 'package:gstock/pages/login.dart';
import 'package:gstock/pages/register.dart';
import 'package:gstock/pages/Membres/list_membres.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'memberlist':(context) => MemberList(),
    },
  ));
}