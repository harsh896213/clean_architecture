import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/feature/chat/data/models/chat_with_participants.dart';

import '../../../../core/di/get_it.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../data/models/chat.dart';
import '../../domain/repository/chat_repository.dart';
import '../bloc/chat/chat_bloc.dart';
import '../bloc/chat/chat_event.dart';
import '../bloc/chat/chat_state.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatListScreen extends StatefulWidget {
  final Function(String, String, String) onChatClick;
  final String? selectedChatId;

  const ChatListScreen({
    super.key,
    required this.onChatClick,
    this.selectedChatId,
  });

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(getIt<ChatRepository>())..add(LoadChats()),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: CustomSearchBar(
              controller: _searchController,
              hintText: 'Search doctors...',
              height: 44,
              iconColor: AppPallete.searchBarIconColor,
              iconSize: 24,
              textColor: AppPallete.searchBarTextColor,
              textStyle: const TextStyle(
                fontSize: 16,
                color: AppPallete.searchBarTextColor,
              ),
              customDecoration: AppTheme.searchBarDecoration(),
              padding: EdgeInsets.zero, // Remove padding since we're already in a Padding widget
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              onClear: () {
                setState(() {
                  _searchQuery = '';
                  _searchController.clear();
                });
              },
            ),
          ),

          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatsLoaded) {
                  final filteredChats = _filterChats(state.chats);

                  if (filteredChats.isEmpty && _searchQuery.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No doctors found matching "$_searchQuery"',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = filteredChats[index];
                      final isSelected = chat.id == widget.selectedChatId;

                      String doctorName = getDoctorName(chat.id);
                      String messagePreview = chat.lastMessage ?? 'No messages yet';
                      String timeAgo = getTimeAgo(index);
                      String specialty = getSpecialtyFromChatId(chat.id);

                      return InkWell(
                        onTap: () {
                          widget.onChatClick(chat.id, doctorName, specialty);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue.withOpacity(0.1) : null,
                            border: isSelected
                                ? Border(
                              left: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                              ),
                            )
                                : null,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.network(
                                  getDoctorImageAsset(chat.id),
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => CircleAvatar(
                                    radius: 22,
                                    backgroundColor: getAvatarColor(chat.id),
                                    child: Text(
                                      getDoctorInitials(doctorName),
                                      style: TextStyle(
                                        color: getAvatarTextColor(chat.id),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                doctorName,
                                                style: context.theme.textTheme.titleMedium,
                                              ),
                                              if (index == 0)
                                                Container(
                                                  margin: const EdgeInsets.only(left: 4),
                                                  child: const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.blue,
                                                    size: 16,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          timeAgo,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 2),

                                    Text(
                                      specialty,
                                      style: context.textTheme.bodyMedium,
                                    ),

                                    const SizedBox(height: 4),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (index % 2 == 0)
                                          Container(
                                            margin: const EdgeInsets.only(top: 4, right: 6),
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        Expanded(
                                          child: Text(
                                            messagePreview,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: context.textTheme.titleLarge
                                                ?.copyWith(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                          ),
                                        ),
                                        if (index == 2)
                                          Container(
                                            margin: const EdgeInsets.only(left: 4),
                                            width: 20,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "1",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
        ],
      ),
    );
  }

  List<ChatWithParticipants> _filterChats(List<ChatWithParticipants> chats) {
    if (_searchQuery.isEmpty) {
      return chats;
    }

    return chats.where((chat) {
      final doctorName = getDoctorName(chat.id).toLowerCase();
      final specialty = getSpecialtyFromChatId(chat.id).toLowerCase();
      final messagePreview = (chat.lastMessage ?? '').toLowerCase();

      return doctorName.contains(_searchQuery) ||
          specialty.contains(_searchQuery) ||
          messagePreview.contains(_searchQuery);
    }).toList();
  }

  String getDoctorName(String chatId) {
    final names = [
      'Sarah Wilson',
      'Michael Chen',
      'Emily Rodriguez',
      'David Park',
      'Lisa Patel',
      'John Smith',
      'Olivia Johnson'
    ];

    int hash = chatId.hashCode.abs();
    return names[hash % names.length];
  }

  String getTimeAgo(int index) {
    if (index == 0) return '52m ago';
    if (index == 1) return '2h ago';
    if (index == 2) return '4h ago';
    return '${index + 1}h ago';
  }

  String getDoctorInitials(String doctorName) {
    List<String> nameParts = doctorName.split(' ');
    if (nameParts.length > 1) {
      return nameParts[0][0] + nameParts[1][0];
    }
    return nameParts[0].substring(0, min(2, nameParts[0].length));
  }

  String getSpecialtyFromChatId(String chatId) {
    final specialties = [
      'Cardiologist',
      'Physical Therapist',
      'Nutritionist',
      'Dermatologist',
      'Psychiatrist',
      'Neurologist',
      'Ophthalmologist',
      'Pediatrician'
    ];

    int hash = chatId.hashCode.abs();
    return specialties[hash % specialties.length];
  }

  String getDoctorImageAsset(String chatId) {
    final int hash = chatId.hashCode.abs();
    final imageAssets = [
      'assets/images/doctors/doctor1.jpg',
      'assets/images/doctors/doctor2.jpg',
      'assets/images/doctors/doctor3.jpg',
      'assets/images/doctors/doctor4.jpg',
    ];

    return imageAssets[hash % imageAssets.length];
  }

  Color getAvatarColor(String chatId) {
    final colors = [
      Colors.blue[100],
      Colors.grey[300],
      Colors.purple[100],
      Colors.green[100],
      Colors.orange[100],
    ];

    int hash = chatId.hashCode.abs();
    return colors[hash % colors.length] ?? Colors.blue[100]!;
  }

  Color getAvatarTextColor(String chatId) {
    final colors = [
      Colors.blue[900],
      Colors.grey[800],
      Colors.purple[900],
      Colors.green[900],
      Colors.orange[900],
    ];

    int hash = chatId.hashCode.abs();
    return colors[hash % colors.length] ?? Colors.blue[900]!;
  }
}