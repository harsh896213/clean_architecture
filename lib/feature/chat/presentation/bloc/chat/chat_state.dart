import 'package:pva/feature/chat/data/models/chat_with_participants.dart';

import '../../../data/models/chat.dart';
import '../../../data/models/message.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatsLoaded extends ChatState {
  final List<ChatWithParticipants> chats;
  ChatsLoaded(this.chats);
}

class MessagesLoading extends ChatState {}

class MessagesLoaded extends ChatState {
  final Stream<List<Message>> messages;
  final String chatId;
  MessagesLoaded(this.messages, this.chatId);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}

class MessagesError extends ChatState {
  final String message;
  MessagesError(this.message);
}