import '../../../data/models/chat.dart';
import '../../../data/models/message.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatsLoaded extends ChatState {
  final List<Chat> chats;

  ChatsLoaded(this.chats);
}

class MessagesLoaded extends ChatState {
  final Stream<List<Message>> messages;

  MessagesLoaded(this.messages);
}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}

class MessagesLoading extends ChatState {}