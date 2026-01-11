import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<void> initDatabase() async {
    _database = await openDatabase(
      'insight_local_pro.db',
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE files_metadata(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            path TEXT,
            name TEXT,
            size INTEGER,
            type TEXT,
            createdAt TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE user_preferences(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            key TEXT,
            value TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE analysis_history(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fileId INTEGER,
            analysisType TEXT,
            result TEXT,
            createdAt TEXT
          )
        ''');
      },
    );
  }

  static Database? get database => _database;
}
