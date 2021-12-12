import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

  class Membre{
    final String nom;
    final String prenom;
    final int tel1;
    final int tel2;

    Membre({
      required this.nom,
      required this.prenom,
      required this.tel1,
      required this.tel2,
    });

    Map<String, dynamic> toMap(){
      return{
        'nom' : nom,
        'prenom' : prenom,
        'tel1' : tel1,
        'tel2' : tel2,
      };
    }

    @override
    String toString() {
      return 'Membre{nom : $nom, prenom : $prenom, tel1 : $tel1, tel2 : $tel2}';
    }
  }