import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/widgets/custom_app_bar.dart';
import 'package:pva/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:pva/feature/chat/presentation/pages/chat_screen.dart';

import '../../../../core/di/get_it.dart';
import '../../domain/repository/chat_repository.dart';
import '../bloc/chat/chat_bloc.dart';
import '../bloc/chat/chat_event.dart';

class MasterDetailChatPage extends StatefulWidget {
  const MasterDetailChatPage({super.key});

  @override
  _MasterDetailChatPageState createState() => _MasterDetailChatPageState();
}

class _MasterDetailChatPageState extends State<MasterDetailChatPage> {
  String? selectedChatId;
  String? selectedDoctorName;
  String? selectedSpecialty;
  bool _isInDetailView = false;
  ChatBloc? _chatBloc;

  @override
  void initState() {
    super.initState();
    _chatBloc = ChatBloc(getIt<ChatRepository>());
    _chatBloc?.add(LoadChats());
  }

  void _onChatClick(String chatId, String doctorName, String speciality) {
    setState(() {
      selectedChatId = chatId;
      selectedDoctorName = doctorName;  // Set the doctor name
      selectedSpecialty = speciality;    // Set the specialty
      _chatBloc?.add(LoadMessages(chatId));
    });

    if (context.isMobile) {
      setState(() {
        _isInDetailView = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            chatId: chatId,
            doctorName: doctorName,
            specialty: speciality,
            onBack: () {
              Navigator.pop(context);
            },
          ),
        ),
      ).then((_) {
        setState(() {
          _isInDetailView = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chatBloc!,
      child: Scaffold(
        appBar: CustomAppBar(
          centerTitle: false,
          title: Text(
            "Messages",
            style: context.textTheme.titleLarge?.copyWith(fontSize: 28),
          ),
        ),
        body: Row(
          children: [
            // Left panel - Chat list
            if (!context.isMobile || !_isInDetailView)
              Expanded(
                flex: 1,
                child: ChatListScreen(
                  onChatClick: _onChatClick,
                  selectedChatId: selectedChatId,
                ),
              ),

            // Add divider between panels on tablet/desktop
            if ((context.isTablet || context.isDesktop) &&
                selectedChatId != null)
              const VerticalDivider(width: 1, thickness: 1, color: Color(0xFFE0E0E0)),

            // Right panel - Chat detail
            if ((context.isTablet || context.isDesktop))
              Expanded(
                flex: 2,
                child: selectedChatId != null && selectedDoctorName != null && selectedSpecialty != null
                    ? ChatScreen(
                  key: ValueKey(selectedChatId),
                  chatId: selectedChatId!,
                  doctorName: selectedDoctorName!,
                  specialty: selectedSpecialty!,
                  onBack: () {
                    setState(() {
                      selectedChatId = null;
                      selectedDoctorName = null;
                      selectedSpecialty = null;
                    });
                  },
                  showAppBar: true,
                )
                    : Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const Center(
                    child: Text(
                      'Select a chat to start conversation',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _chatBloc?.close();
    super.dispose();
  }
}

