import '../../../../core/common/entities/user.dart';
import '../../domain/repository/chat_repository.dart';
import '../datasources/local_chat_data_source_impl.dart';
import '../models/chat.dart';
import '../models/message.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource localDataSource;

  ChatRepositoryImpl({required this.localDataSource});

  @override
  Future<void> init() async {
    await localDataSource.init();
  }

  @override
  Future<void> saveMessage(Message message) async {
    await localDataSource.saveMessage(message);
  }

  @override
  Stream<List<Message>> watchMessages(String chatId) {
    return localDataSource.watchMessages(chatId);
  }

  @override
  Future<List<Chat>> getAllChats() async {
    return await localDataSource.getAllChats();
  }

  @override
  Future<List<User>> getUsers(List<String> userIds) async {
    return await localDataSource.getUsers(userIds);
  }
}