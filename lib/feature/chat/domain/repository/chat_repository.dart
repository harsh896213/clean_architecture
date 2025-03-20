import 'package:pva/feature/chat/data/models/chat_with_participants.dart';

import '../../../../core/common/entities/user.dart';
import '../../data/models/message.dart';

abstract class ChatRepository {
  Future<void> init();
  Future<void> saveMessage(Message message);
  Stream<List<Message>> watchMessages(String chatId);
  Future<List<ChatWithParticipants>> getAllChats();
  Future<List<User>> getUsers(List<String> userIds);
}