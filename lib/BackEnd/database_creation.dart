import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:gstock/BackEnd/Models/admin_model.dart';
import 'package:gstock/BackEnd/Models/category_model.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:gstock/BackEnd/Models/emprunt_model.dart';
import 'package:gstock/BackEnd/Models/membre_model.dart';
import 'package:gstock/BackEnd/Models/retour_model.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class Dbcreate{

  Future<Database> main() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path =join(documentsDirectory.path,"gstock.db");
      return await openDatabase(path,

      onCreate: (db, version)async{
        await db.execute('''
          CREATE TABLE membre(
              nom STRING,
              prenom STRING,
              tel1 INTEGER,
              tel2 INTEGER
              )
        ''');

        await db.execute('''
          CREATE TABLE category(
          name STRING
          )
        ''');

        await db.execute('''
          CREATE TABLE composant(
          name STRING,
          obtenue STRING,
          FK_category INTEGER,
          FOREIGN KEY (FK_category) REFERENCES category (rowid)
          )
        ''');

        await db.execute('''
          CREATE TABLE admin(
          name STRING,
          password STRING
          )
        ''');

        await db.execute('''
          CREATE TABLE emprunt(
          FK_composant INTEGER,
          date STRING,
          FOREIGN KEY (FK_composant) REFERENCES composant (rowid)
          )
        ''');

        await db.execute('''
          CREATE TABLE retour(
          FK_composant INTEGER,
          date STRING,
          etat STRING,
          FOREIGN KEY (FK_composant) REFERENCES composant (rowid)
          )
        ''');
      },
      version: 1,
    );
  }
  //-----ADMIN-----
  Future<int> insertAdmin(Admin admin) async{
    final db = await main();
    return db.insert(
      'admin',
      admin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<Admin>> fetchAdmin() async{
    final db = await main();
    final List<Map<String, dynamic>> maps = await db.query('admin');
    return List.generate(maps.length, (i){
      return Admin(
          name: maps[i]['name'],
          password: maps[i]['password'],
      );
    });
  }
  //-----CATEGORY-----
  //-----COMPOSANT-----
  //-----MEMBRE-----
  //-----EMPRUNT-----
  //-----RETOUR-----
  }