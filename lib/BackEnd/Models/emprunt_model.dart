import 'dart:async';

import 'package:gstock/BackEnd/Models/category_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

  class Emprunt{
    final int composant;
    final DateTime date;

    Emprunt({
      required this.date,
      required this.composant,
    });

    Map<String, dynamic> toMap(){
      return{
        'FK_composant' : composant,
        'date' : date.toIso8601String(),
      };
    }

    @override
    String toString() {
      return 'Emprunt{composant $composant, date : $date}';
    }
  }