import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../../domain/repository/chat_repository.dart';
import '../bloc/chat/chat_bloc.dart';
import '../bloc/chat/chat_event.dart';
import '../bloc/chat/chat_state.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(getIt<ChatRepository>())..add(LoadChats()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Chats')),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatsLoaded) {
              return ListView.builder(
                itemCount: state.chats.length,
                itemBuilder: (context, index) {
                  final chat = state.chats[index];
                  return ListTile(
                    title: Text('Chat ${chat.id}'),
                    subtitle: Text(chat.lastMessage ?? 'No messages yet'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(chatId: chat.id),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is ChatError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('No chats available'));
          },
        ),
      ),
    );
  }
}