import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optiguard/feature/education/model/article.dart';
import 'package:optiguard/shared/util/data_loader/articles.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String TABLE_IMAGES = 'images';
const String TABLE_ARTICLES = 'articles';

final dbLoadProvider = Provider((ref) => DatabaseLoader());

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
    log("Database path: $path");
    Database db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $TABLE_IMAGES(
        id INTEGER PRIMARY KEY,
        userId INTEGER,
        imagePath TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $TABLE_ARTICLES(
        id TEXT PRIMARY KEY,
        title TEXT,
        content TEXT,
        image TEXT,
        date TEXT,
        view INTEGER
      );
    ''');

    await _seedDbArticles(db);
  }

  Future<void> _seedDbArticles(Database db) async {
    Batch batch = db.batch();

    List<Article> articles = loadArticles();

    for (final article in articles) {
      batch.insert(TABLE_ARTICLES, article.toMap());
    }

    await batch.commit();
  }

  Future<int> insertImage(int userId, String imagePath) async {
    Database db = await database;
    return await db
        .insert(TABLE_IMAGES, {'userId': userId, 'imagePath': imagePath});
  }

  Future<List<Map<String, dynamic>>> getImagesByUserId(int userId) async {
    Database db = await database;
    return await db.query(
      TABLE_IMAGES,
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<List<Article>> getArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_ARTICLES);
    return List.generate(maps.length, (i) {
      return Article.fromMap(maps[i]);
    });
  }

  Future<Article> getArticleById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_ARTICLES,
        where: 'id = ?', whereArgs: [id], limit: 1);
    return Article.fromMap(maps.first);
  }
}
