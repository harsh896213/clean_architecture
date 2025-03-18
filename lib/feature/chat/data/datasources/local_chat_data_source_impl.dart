import 'dart:async';
import 'dart:convert';

import 'package:pva/core/constants/constants.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/local/database/data/database_helper.dart';
import '../models/chat.dart';
import '../models/message.dart';

abstract interface class ChatLocalDataSource {
  Future<void> init();
  Future<void> saveMessage(Message message);
  Stream<List<Message>> watchMessages(String chatId);
  Future<List<Chat>> getAllChats();
  Future<List<User>> getUsers(List<String> userIds);
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final DatabaseHelper databaseHelper;
  final StreamController<List<Message>> _messageStreamController = StreamController<List<Message>>.broadcast();


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
      {
        'id': message.id,
        'chatId': message.chatId,
        'senderId': message.senderId,
        'content': message.content,
        'timestamp': message.timestamp.millisecondsSinceEpoch,
        'status': message.status.index,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    final updatedMessages = await _fetchMessages(message.chatId);
    _messageStreamController.add(updatedMessages);
  }

  @override
  Stream<List<Message>> watchMessages(String chatId) async* {
    final initialMessages = await _fetchMessages(chatId);
    yield initialMessages;
    yield* _messageStreamController.stream;
  }

  Future<List<Message>> _fetchMessages(String chatId) async {
    final db = databaseHelper.database;
    final results = await db.query(
      Constants.tableNameMessage,
      where: 'chatId = ?',
      whereArgs: [chatId],
    );
    return results.map((map) => Message(
      id: map['id'] as String,
      chatId: map['chatId'] as String,
      senderId: map['senderId'] as String,
      content: map['content'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      status: MessageStatus.values[map['status'] as int],
    )).toList();
  }

  @override
  Future<List<Chat>> getAllChats() async {
    final db = databaseHelper.database;
    final results = await db.query(Constants.tableNameChat);
    print('Fetched chats: $results'); // Debug statement
    return results.map((map) => Chat(
      id: map['id'] as String,
      participantIds: (jsonDecode(map['participantIds'] as String) as List<dynamic>).cast<String>(),
      lastActivity: DateTime.fromMillisecondsSinceEpoch(map['lastActivity'] as int),
      lastMessage: map['lastMessage'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    )).toList();
  }

  @override
  Future<List<User>> getUsers(List<String> userIds) async {
    final db = databaseHelper.database;
    final results = await db.query(
      Constants.tableNameUsers,
      where: 'id IN (${userIds.map((_) => '?').join(',')})',
      whereArgs: userIds,
    );
    return results.map((map) => User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      type: UserType.values[map['type'] as int],
    )).toList();
  }

  void dispose() {
    _messageStreamController.close();
  }
}
