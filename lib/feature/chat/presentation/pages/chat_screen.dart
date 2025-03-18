// presentation/pages/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../../data/models/message.dart';
import '../../domain/repository/chat_repository.dart';
import '../bloc/chat/chat_bloc.dart';
import '../bloc/chat/chat_event.dart';
import '../bloc/chat/chat_state.dart';
import '../widgets/message_input.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(getIt<ChatRepository>())..add(LoadMessages(widget.chatId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Chat')),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is MessagesLoaded) {
                    return StreamBuilder<List<Message>>(
                      stream: state.messages,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final messages = snapshot.data!;

                          // Scroll to the bottom when new messages are added
                          _scrollToBottom();

                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return ListTile(
                                title: Text(message.content),
                                subtitle: Text(message.timestamp.toString()),
                              );
                            },
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            const MessageInput(),
          ],
        ),
      ),
    );
  }
}