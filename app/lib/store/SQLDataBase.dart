import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SQLDataBase {
  Database? _db;
  static SQLDataBase dataBase = SQLDataBase();

  Future<SQLDataBase> instance() async {
    if (dataBase._db == null) {
      Directory userDir = await getApplicationDocumentsDirectory();
      String dbDir = join(userDir.path, "medio.db");
      dataBase._db = await openDatabase(dbDir, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
        await db.execute('''
            CREATE TABLE students(id TEXT PRIMARY KEY, name TEXT, score INTEGER);
            CREATE TABLE students1(id TEXT PRIMARY KEY, name TEXT, score INTEGER);
            ''');
      });
    }
    return dataBase;
  }
}
