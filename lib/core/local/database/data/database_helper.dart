import 'dart:convert';

import 'package:pva/core/constants/constants.dart';
import 'package:pva/core/local/database/domain/database_repository.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';

import '../../../../feature/appointment/data/models/appointment.dart';

class DatabaseHelper implements DatabaseRepository {
  static Database? _database;

  Future<void> getDatabase() async {
    if (_database != null) return;

    String dbPath = join(await getDatabasesPath(), 'my_encrypted_db.db');

    _database = await openDatabase(
      dbPath,
      version: 1,
      password: 'your_secret_passphrase',
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE ${Constants.tableNameUsers}(
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            email TEXT,
            type INTEGER NOT NULL
          )
        ''');
        db.execute('''
          CREATE TABLE ${Constants.tableNameChat}(
            id TEXT PRIMARY KEY,
            participantIds TEXT NOT NULL,
            lastActivity INTEGER NOT NULL,
            lastMessage TEXT,
            createdAt INTEGER NOT NULL
          )
        ''');
        db.execute('''
          CREATE TABLE ${Constants.tableNameMessage}(
            id TEXT PRIMARY KEY,
            chatId TEXT NOT NULL,
            senderId TEXT NOT NULL,
            content TEXT NOT NULL,
            timestamp INTEGER NOT NULL,
            status INTEGER NOT NULL
          )
        ''');
        db.execute('''
      CREATE TABLE appointments(
        id TEXT PRIMARY KEY,
        doctorName TEXT,
        specialty TEXT,
        dateTime TEXT,
        isVirtual INTEGER
      )
    ''');
      },
    );
    seedDummyData();
    print('Database initialized successfully'); // Debug statement
  }

  // Add this in your main function or a separate function
  Future<void> seedDummyData() async {
    final db = database;

    // Insert dummy users
    await db.insert(
      Constants.tableNameUsers,
      {
        'id': '1',
        'name': 'Dr. Smith',
        'type': 0, // Assuming 0 is the index for UserType.doctor
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.insert(
      Constants.tableNameUsers,
      {
        'id': '2',
        'name': 'Patient John',
        'type': 2, // Assuming 2 is the index for UserType.patient
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Insert dummy chat
    await db.insert(
      Constants.tableNameChat,
      {
        'id': 'chat1',
        'participantIds': jsonEncode(['1', '2']), // Encode as JSON array
        'lastActivity': DateTime.now().millisecondsSinceEpoch,
        'lastMessage': 'Hello!',
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Insert dummy message
    await db.insert(
      Constants.tableNameMessage,
      {
        'id': 'msg1',
        'chatId': 'chat1',
        'senderId': '1',
        'content': 'Hello!',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'status': 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final dummyAppointments = [
      AppointmentModel(
        id: '1',
        doctorName: 'Dr. Sarah Wilson',
        specialty: 'Cardiologist',
        dateTime: DateTime(2025, 3, 18, 10, 0),
        isVirtual: 1,
      ),
      AppointmentModel(
        id: '2',
        doctorName: 'Dr. John Doe',
        specialty: 'Dermatologist',
        dateTime: DateTime(2025, 3, 19, 14, 0),
        isVirtual: 0,
      ),
    ];

    for (var appointment in dummyAppointments) {
      await db.insert(Constants.tableNameAppointments, appointment.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    print('Dummy data seeded successfully'); // Debug statement
  }

  Database get database {
    if (_database == null) {
      throw Exception('Database is not initialized');
    }
    return _database!;
  }

  @override
  Future<void> insert(Map<String, dynamic> data, String tableName) async {
    await database.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String tableName) async {
    return await database.query(tableName);
  }

  @override
  Future<void> close() async {
    await database.close();
  }

  @override
  Future<void> insertBatch<T>(
    List<T> objects,
    String tableName,
    Map<String, dynamic> Function(T) toMap,
  ) async {
    Batch batch = database.batch();

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
    int offset = (page - 1) * pageSize;

    List<Map<String, dynamic>> results = await database.query(
      tableName,
      limit: pageSize,
      offset: offset,
    );

    return List.generate(results.length, (index) => fromMap(results[index]));
  }
}
