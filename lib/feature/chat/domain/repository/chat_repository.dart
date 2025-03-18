import '../../../../core/common/entities/user.dart';
import '../../data/models/chat.dart';
import '../../data/models/message.dart';

abstract class ChatRepository {
  Future<void> init();
  Future<void> saveMessage(Message message);
  Stream<List<Message>> watchMessages(String chatId);
  Future<List<Chat>> getAllChats();
  Future<List<User>> getUsers(List<String> userIds);
}