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

class Dbcreate {
  Future<Database> main() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "gstock.db");
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS membre(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nom STRING,
              prenom STRING,
              tel1 INTEGER,
              tel2 INTEGER
              )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS category(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name STRING UNIQUE
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS composant(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name STRING,
          obtenue STRING,
          stock INTEGER,
          FK_category INTEGER,
          FOREIGN KEY (FK_category) REFERENCES category (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS admin(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name STRING,
          password STRING
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS emprunt(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          FK_composant INTEGER,
          date STRING,
          FOREIGN KEY (FK_composant) REFERENCES composant (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS retour(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          FK_composant INTEGER,
          date STRING,
          etat STRING,
          FOREIGN KEY (FK_composant) REFERENCES composant (id)
          )
        ''');
      },
      version: 1,
    );
  }

  //------------------[ADMIN FUNCTIONS]------------------
  Future<int> insertAdmin(Admin admin) async {
    final db = await main();
    return db.insert(
      'admin',
      admin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Admin>> fetchAdmin() async {
    final db = await main();
    final List<Map<String, dynamic>> maps = await db.query('admin');
    return List.generate(maps.length, (i) {
      return Admin(
        id: maps[i]['id'],
        name: maps[i]['name'],
        password: maps[i]['password'],
      );
    });
  }

  //------------------[CATEGORY  FUNCTIONS]------------------
  Future<int> insertCateg(Category category) async {
    final db = await main();
    return db.insert(
      'category',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Category>> fetchCateg() async {
    final db = await main();
    final List<Map<String, dynamic>> maps = await db.query('category');
    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  Future<int> deleteCateg(int id) async {
    //returns number of items deleted
    final db = await main();

    int result = await db.delete("category", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );
    return result;
  }

  Future<int> updateCateg(int id, Category item) async {
    // returns the number of rows updated

    final db = await main();

    int result = await db
        .update("category", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }
//------------------[COMPOSANT  FUNCTIONS]------------------
//------------------[MEMBRE  FUNCTIONS]------------------
//------------------[EMPRUNT  FUNCTIONS]------------------
//------------------[RETOUR  FUNCTIONS]------------------
}
