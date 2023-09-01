import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../entity/adverb.dart';

class DBProvider extends ChangeNotifier {
  static Database? _database;

  final BuildContext context;

  DBProvider({required this.context});

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'english.db');
    print([path]);

    String schema = await DefaultAssetBundle.of(context).loadString(
      "assets/schema.sql",
    );

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(schema);
      }
    );
  }

  Future<List<Adverb>> findAdverbs() async {
    final db = await database;
    final rows = await db.query('adverb');

    return rows.isNotEmpty
        ? rows.map((row) => Adverb.fromMap(row)).toList()
        : [];
  }
}