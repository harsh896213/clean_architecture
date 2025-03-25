import 'package:path/path.dart';
import 'package:pva/core/constants/constants.dart';
import 'package:pva/core/local/database/domain/database_repository.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'dummy_data.dart';

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
            email TEXT NOT NULL UNIQUE,
            type INTEGER NOT NULL,
            specialty TEXT 
          )
        ''');
        db.execute('''
          CREATE TABLE ${Constants.tableNameChat}(
            id TEXT PRIMARY KEY,
            lastActivity INTEGER NOT NULL,
            lastMessage TEXT,
            createdAt INTEGER NOT NULL
          )
        ''');
        db.execute('''
        CREATE TABLE ${Constants.tableNameChatParticipants} (
          chatId TEXT NOT NULL,
          userId TEXT NOT NULL,
          FOREIGN KEY(chatId) REFERENCES Chats(id),
          FOREIGN KEY(userId) REFERENCES Users(id),
          PRIMARY KEY (chatId, userId))
        ''');
        db.execute('''
          CREATE TABLE ${Constants.tableNameMessage}(
            id TEXT PRIMARY KEY,
            chatId TEXT NOT NULL,
            senderId TEXT NOT NULL,
            content TEXT NOT NULL,
            timestamp INTEGER NOT NULL,
            status INTEGER NOT NULL,
            FOREIGN KEY(chatId) REFERENCES Chats(id),
            FOREIGN KEY(senderId) REFERENCES Users(id)
          )
        ''');
        db.execute('''
    CREATE TABLE IF NOT EXISTS ${Constants.tableNameAppointments} (
      id TEXT PRIMARY KEY,
      doctorId TEXT NOT NULL,
      patientId TEXT NOT NULL,
      dateTime INTEGER NOT NULL,
      isVirtual INTEGER NOT NULL,
      profilePic TEXT,
      FOREIGN KEY(doctorId) REFERENCES Users(id),
      FOREIGN KEY(patientId) REFERENCES Users(id)
    )
  ''');
      },
    );
    seedDummyData();
    print('Database initialized successfully'); // Debug statement
  }

  Future<void> seedDummyData() async {
    final db = database;

    // Insert dummy users
    for (var user in users) {
      await db.insert(Constants.tableNameUsers, user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }

    // Insert dummy chats
    for (var chat in chats) {
      await db.insert(Constants.tableNameChat, chat.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }

    // Insert participants for each chat
    for (var participant in chatParticipants) {
      await db.insert(Constants.tableNameChatParticipants, participant, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    for(var message in messages) {
      await db.insert(Constants.tableNameMessage, message.toJson(), conflictAlgorithm:  ConflictAlgorithm.replace);
    }

    for(var appointment in appointments) {
      await db.insert(Constants.tableNameAppointments, appointment.toMap(), conflictAlgorithm:  ConflictAlgorithm.replace);
    }

    print('Dummy data seeded successfully');
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
