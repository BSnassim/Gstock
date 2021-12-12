import 'package:flutter/widgets.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class Dbcreate{

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'gstock.db'),

      onCreate: (db, version)async{
        await db.execute('''
          CREATE TABLE membre(
              nom STRING,
              prenom STRING,
              tel1 INTEGER,
              tel2 INTEGER,
              )
        ''');

        await db.execute('''
          CREATE TABLE category(
          name STRING,
          )
        ''');

        await db.execute('''
          CREATE TABLE composant(
          name STRING,
          obtenue STRING,
          FK_category INTEGER,
          FOREIGN KEY (FK_category) REFERENCES category (rowid), 
          )
        ''');

        await db.execute('''
          CREATE TABLE admin(
          name STRING,
          password STRING,
          )
        ''');

        await db.execute('''
          CREATE TABLE emprunt(
          FK_composant INTEGER,
          date STRING,
          FOREIGN KEY (FK_composant) REFERENCES composant (rowid),
          )
        ''');

        await db.execute('''
          CREATE TABLE retour(
          FK_composant INTEGER,
          date STRING,
          etat STRING,
          FOREIGN KEY (FK_composant) REFERENCES composant (rowid),
          )
        ''');
      },
      version: 1,
    );

  }
  }