import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLoader {
  static final DatabaseLoader _instance = DatabaseLoader._internal();
  static Database? _database;

  factory DatabaseLoader() => _instance;

  DatabaseLoader._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'db_optiguard.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE images(
        id INTEGER PRIMARY KEY,
        userId INTEGER,
        imagePath TEXT
      )
    ''');
  }

  Future<int> insertImage(int userId, String imagePath) async {
    Database db = await database;
    return await db
        .insert('images', {'userId': userId, 'imagePath': imagePath});
  }

  Future<List<Map<String, dynamic>>> getImagesByUserId(int userId) async {
    Database db = await database;
    return await db.query(
      'images',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }
}
