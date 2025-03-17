import 'package:pva/core/local/database/domain/database_repository.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper implements DatabaseRepository {
  static Database? _database;

  static Future<Database> _getDatabase() async {
    if (_database != null) return _database!;

    String dbPath = join(await getDatabasesPath(), 'my_encrypted_db.db');

    _database = await openDatabase(
      dbPath,
      version: 1,
      password: 'your_secret_passphrase',
      onCreate: (db, version) {
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

  @override
  Future<void> insert(Map<String, dynamic> data, String tableName) async {
    final db = await _getDatabase();
    await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String tableName) async {
    final db = await _getDatabase();
    return await db.query(tableName);
  }

  @override
  Future<void> close() async {
    final db = await _getDatabase();
    await db.close();
  }

  @override
  Future<void> insertBatch<T>(
    List<T> objects,
    String tableName,
    Map<String, dynamic> Function(T) toMap,
  ) async {
    final db = await _getDatabase();
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

  @override
  Future<List<T>> getPaginated<T>(
    int page,
    int pageSize,
    String tableName,
    T Function(Map<String, dynamic>) fromMap,
  ) async {
    final db = await _getDatabase();
    int offset = (page - 1) * pageSize;

    List<Map<String, dynamic>> results = await db.query(
      tableName,
      limit: pageSize,
      offset: offset,
    );

    return List.generate(results.length, (index) => fromMap(results[index]));
  }
}
