import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optiguard/feature/education/model/article.dart';
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

    List<Article> articles = [
      Article(
        id: 'adkasd',
        title: 'Jaga Kesehatan Mata di Era Digital',
        content:
            'Pada era digital seperti sekarang ini, mata kita sering kali terpapar oleh layar gadget. Hal ini dapat menyebabkan mata menjadi cepat lelah dan mengalami gangguan. Oleh karena itu, penting bagi kita untuk menjaga kesehatan mata kita dengan cara yang benar.',
        image: 'image1.jpg',
        date: DateTime(2024, 5, 1, 17, 39),
        view: 100,
      ),
      Article(
        id: '24fawdasd',
        title: 'Jaga Kesehatan Mata di Era Digital',
        content:
            'Pada era digital seperti sekarang ini, mata kita sering kali terpapar oleh layar gadget. Hal ini dapat menyebabkan mata menjadi cepat lelah dan mengalami gangguan. Oleh karena itu, penting bagi kita untuk menjaga kesehatan mata kita dengan cara yang benar.',
        image: 'image2.jpg',
        date: DateTime(2024, 5, 2, 17, 39),
        view: 200,
      ),
      Article(
        id: 'a9udhahd',
        title: 'Jaga Kesehatan Mata di Era Digital',
        content:
            'Pada era digital seperti sekarang ini, mata kita sering kali terpapar oleh layar gadget. Hal ini dapat menyebabkan mata menjadi cepat lelah dan mengalami gangguan. Oleh karena itu, penting bagi kita untuk menjaga kesehatan mata kita dengan cara yang benar.',
        image: 'image3.jpg',
        date: DateTime(2024, 5, 3, 17, 39),
        view: 300,
      ),
    ];

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
}
