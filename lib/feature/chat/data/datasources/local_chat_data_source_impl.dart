import 'dart:async';

import 'package:pva/core/constants/constants.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/local/database/data/database_helper.dart';
import '../models/chat_with_participants.dart';
import '../models/message.dart';

abstract interface class ChatLocalDataSource {
  Future<void> init();

  Future<void> saveMessage(Message message);

  Stream<List<Message>> watchMessages(String chatId);

  Future<List<ChatWithParticipants>> getAllChats();

  Future<List<User>> getUsers(List<String> userIds);
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final DatabaseHelper databaseHelper;
  final StreamController<Message?> _messageStreamController =
      StreamController<Message?>.broadcast();

  ChatLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> init() async {
    await databaseHelper.getDatabase();
  }

  @override
  Future<void> saveMessage(Message message) async {
    final db = databaseHelper.database;
    await db.insert(
      Constants.tableNameMessage,
      message.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _messageStreamController.add(null);
  }

  @override
  Stream<List<Message>> watchMessages(String chatId) async* {
    final initialMessages = await _fetchMessages(chatId);
    print('All Messages: $initialMessages');
    yield initialMessages;

    // Listen to new messages for the specific chatId
    yield* _messageStreamController.stream.asyncMap((_) async {
      return await _fetchMessages(chatId);
    });
  }

  Future<List<Message>> _fetchMessages(String chatId) async {
    final db = databaseHelper.database;
    final results = await db.query(
      Constants.tableNameMessage,
      where: 'chatId = ?',
      whereArgs: [chatId],
    );
    return results.map((map) => Message.fromJson(map)).toList();
  }

  Future<List<ChatWithParticipants>> getAllChats() async {
    final db = databaseHelper.database;
    final result = await db.rawQuery('''
    SELECT 
      Chats.id AS chatId,
      Chats.lastActivity,
      Chats.lastMessage,
      Chats.createdAt,
      GROUP_CONCAT(ChatParticipants.userId) AS participantIds
    FROM Chats
    JOIN ChatParticipants ON Chats.id = ChatParticipants.chatId
    GROUP BY Chats.id
  ''');

    // Convert the result into a list of ChatWithParticipants objects
    return result.map((map) => ChatWithParticipants.fromMap(map)).toList();
  }

  @override
  Future<List<User>> getUsers(List<String> userIds) async {
    final db = databaseHelper.database;
    final results = await db.query(
      Constants.tableNameUsers,
      where: 'id IN (${userIds.map((_) => '?').join(',')})',
      whereArgs: userIds,
    );
    return results
        .map((map) => User(
              id: map['id'] as String,
              name: map['name'] as String,
              email: map['email'] as String,
              type: UserType.values[map['type'] as int],
            ))
        .toList();
  }

  void dispose() {
    _messageStreamController.close();
  }
}
