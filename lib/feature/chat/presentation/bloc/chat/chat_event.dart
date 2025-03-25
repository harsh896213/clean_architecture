
import '../../../data/models/message.dart';

abstract class ChatEvent {}

class LoadChats extends ChatEvent {}

class SendMessage extends ChatEvent {
  final Message message;
  SendMessage(this.message);
}

class LoadMessages extends ChatEvent {
  final String chatId;
  LoadMessages(this.chatId);
}