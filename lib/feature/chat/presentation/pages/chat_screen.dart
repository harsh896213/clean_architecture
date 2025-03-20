import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/get_it.dart';
import '../../data/models/message.dart';
import '../../domain/repository/chat_repository.dart';
import '../bloc/chat/chat_bloc.dart';
import '../bloc/chat/chat_event.dart';
import '../bloc/chat/chat_state.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final VoidCallback? onBack;
  final bool showAppBar;

  const ChatScreen({
    super.key,
    required this.chatId,
    this.onBack,
    this.showAppBar = true,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  late ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _chatBloc = ChatBloc(getIt<ChatRepository>())..add(LoadMessages(widget.chatId));
  }

  @override
  void didUpdateWidget(ChatScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If chatId changed, reload messages
    if (oldWidget.chatId != widget.chatId) {
      _chatBloc.add(LoadMessages(widget.chatId));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // Don't close the bloc here if it's provided externally
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
    return BlocProvider.value(
      value: _chatBloc,
      child: Builder(
          builder: (context) {
            final Widget body = Column(
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

                              return messages.isEmpty
                                  ? const Center(child: Text('No messages yet. Start a conversation!'))
                                  : ListView.builder(
                                controller: _scrollController,
                                padding: const EdgeInsets.all(16),
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  final message = messages[index];
                                  return MessageBubble(message: message);
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            }
                            return const Center(child: CircularProgressIndicator());
                          },
                        );
                      } else if (state is MessagesError) {
                        return Center(child: Text(state.message));
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                const MessageInput(),
              ],
            );

            if (widget.showAppBar) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Chat ${widget.chatId}'),
                  leading: widget.onBack != null ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: widget.onBack,
                  ) : null,
                ),
                body: body,
              );
            } else {
              return body;
            }
          }
      ),
    );
  }
}
