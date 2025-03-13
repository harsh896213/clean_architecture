import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static Database? _database;

  // create the encrypted database
  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    // Get the path to the database
    String dbPath = join(await getDatabasesPath(), 'my_encrypted_db.db');

    // Open the database with a password
    _database = await openDatabase(
      dbPath,
      version: 1,
      password: 'your_secret_passphrase', // Set your passphrase here
      onCreate: (db, version) {
        // Create a table when the database is first created
        db.execute('''
          CREATE TABLE User(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER
          )
        ''');
      },
    );
    return _database!;
  }

  // to insert the data
  static Future<void> insertData(Map<String, dynamic> data, String tableName) async {
    final db = await getDatabase();
    await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //to retrieve all data
  static Future<List<Map<String, dynamic>>> getAllData(String tableName) async {
    final db = await getDatabase();
    return await db.query('tableName');
  }

  static Future<void> closeDatabase() async {
    final db = await getDatabase();
    await db.close();
  }

  static Future<void> insertWithTransaction<T>(
      List<T> objects,
      String tableName,
      Map<String, dynamic> Function(T) toMap,
      ) async {
    final db = await getDatabase();
    await db.transaction((txn) async {
      for (var object in objects) {
        await txn.insert(
          tableName,
          toMap(object),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  static Future<List<T>> fetchPaginated<T>(
      int page,
      int pageSize,
      String tableName,
      T Function(Map<String, dynamic>) fromMap,
      ) async {
    final db = await getDatabase();

    int offset = (page - 1) * pageSize;

    List<Map<String, dynamic>> results = await db.query(
      tableName,
      limit: pageSize, // Number of records per page
      offset: offset, // Number of records to skip
    );

    return List.generate(results.length, (index) {
      return fromMap(results[index]);
    });
  }

  static Future<void> insertUsersBatch<T>(
      List<T> objects,
      String tableName,
      Map<String, dynamic> Function(T) toMap,) async {
    final db = await getDatabase();

    Batch batch = db.batch();

    for (var object in objects) {
      batch.insert(
        tableName,
        toMap(object),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

}
