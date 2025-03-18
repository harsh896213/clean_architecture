import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc(this.chatRepository) : super(ChatInitial()) {
    on<LoadChats>(_onLoadChats);
    on<SendMessage>(_onSendMessage);
    on<LoadMessages>(_onLoadMessages);
  }

  Future<void> _onLoadChats(LoadChats event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final chats = await chatRepository.getAllChats();
      emit(ChatsLoaded(chats));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      await chatRepository.saveMessage(event.message);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) async {
    emit(MessagesLoading());
    try {
      final messagesStream = chatRepository.watchMessages(event.chatId);
      emit(MessagesLoaded(messagesStream));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}