import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/core/extension/context_ext.dart';

import '../../../../core/di/get_it.dart';
import '../../data/models/message.dart';
import '../../domain/repository/chat_repository.dart';
import '../bloc/chat/chat_bloc.dart';
import '../bloc/chat/chat_event.dart';
import '../bloc/chat/chat_state.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_field.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String doctorName;
  final String specialty;
  final VoidCallback? onBack;
  final bool showAppBar;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.doctorName,
    required this.specialty,
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

  String _getDoctorName(String chatId) {
    return "Dr. Sarah Wilson";
  }

  String _getDoctorSpecialty(String chatId) {
    return "Cardiologist";
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
                              _scrollToBottom();
                              return messages.isEmpty
                                  ? const Center(child: Text('No messages yet. Start a conversation!'))
                                  : Container(
                                color: const Color(0xFFF5F8FA),
                                child: ListView.builder(
                                  controller: _scrollController,
                                  padding: const EdgeInsets.all(16),
                                  itemCount: messages.length,
                                  itemBuilder: (context, index) {
                                    final message = messages[index];
                                    return ChatMessageBubble(
                                      message: message,
                                      showAvatar: message.senderId == '1',
                                    );
                                  },
                                ),
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
                ChatInputField(onSend: (text) {
                  final message = Message(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    senderId: '1',
                    content: text,
                    timestamp: DateTime.now(),
                    status: MessageStatus.sent, chatId: widget.chatId,
                  );
                  context.read<ChatBloc>().add(SendMessage(message));
                }),
              ],
            );

            if (widget.showAppBar) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  leading: widget.onBack != null
                      ? IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: widget.onBack,
                  )
                      : null,
                  titleSpacing: 0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.green[100],
                        child: Text(
                          widget.doctorName.split(' ').map((e) => e[0]).take(2).join(),
                          style: TextStyle(
                            color: Colors.green[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Dr. ${widget.doctorName}',
                            style: context.textTheme.titleMedium?.copyWith(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            widget.specialty,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      )
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.phone_outlined, color: Colors.black87),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.videocam_outlined, color: Colors.black87),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.black87),
                      onPressed: () {},
                    ),
                  ],
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
