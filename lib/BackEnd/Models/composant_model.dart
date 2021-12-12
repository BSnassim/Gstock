import 'dart:async';

import 'package:gstock/BackEnd/Models/category_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

  class Composant{
    final String name;
    final DateTime obtenue;
    final int category;

    Composant({
      required this.name,
      required this.obtenue,
      required this.category,
    });

    Map<String, dynamic> toMap(){
      return{
        'name' : name,
        'obtenue' : obtenue.toIso8601String(),
        'FK_category' : category,
      };
    }

    @override
    String toString() {
      return 'Composant{name : $name, obtenue : $obtenue, category : $category}';
    }
  }