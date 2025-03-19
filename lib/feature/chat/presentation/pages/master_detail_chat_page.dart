import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:pva/feature/chat/presentation/pages/chat_screen.dart';


class MasterDetailChatPage extends StatefulWidget {
  const MasterDetailChatPage({super.key});

  @override
  _MasterDetailChatPageState createState() => _MasterDetailChatPageState();
}

class _MasterDetailChatPageState extends State<MasterDetailChatPage> {
  String? selectedChatId;

  void _onChatClick(String chatId) {
    setState(() {
      selectedChatId = chatId;
    });

    if (context.isMobile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(chatId: chatId),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: ChatListScreen(onChatClick: _onChatClick),
          ),
          if (context.isTablet || context.isDesktop)
            Expanded(
              flex: 3,
              child: selectedChatId != null
                  ? ChatScreen(chatId: selectedChatId!)
                  : const Center(child: Text('Select a chat')),
            ),
        ],
      ),
    );
  }
}