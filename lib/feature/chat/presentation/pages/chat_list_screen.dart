import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/get_it.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/repository/chat_repository.dart';
import '../bloc/chat/chat_bloc.dart';
import '../bloc/chat/chat_event.dart';
import '../bloc/chat/chat_state.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatelessWidget {
  final Function(String, String, String) onChatClick;  // Updated to pass more data
  final String? selectedChatId;

  const ChatListScreen({
    super.key,
    required this.onChatClick,
    this.selectedChatId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(getIt<ChatRepository>())..add(LoadChats()),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Container(
              height: 44,
              decoration: AppTheme.searchBarDecoration(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: AppPallete.searchBarIconColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: AppTheme.searchInputDecoration(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppPallete.searchBarTextColor,
                      ),
                      onChanged: (value) {
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatsLoaded) {
                  return ListView.builder(
                    itemCount: state.chats.length,
                    itemBuilder: (context, index) {
                      final chat = state.chats[index];
                      final isSelected = chat.id == selectedChatId;

                      String doctorName = getDoctorName(chat.id);
                      String messagePreview = chat.lastMessage ?? 'No messages yet';
                      String timeAgo = getTimeAgo(index);
                      String specialty = getSpecialtyFromChatId(chat.id);

                      return InkWell(
                        onTap: () {
                          onChatClick(chat.id, doctorName, specialty);
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
                                  getDoctorImageUrl(chat.id),
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
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
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
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
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
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600],
                                            ),
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

  String getDoctorImageUrl(String chatId) {
    final int hash = chatId.hashCode.abs();
    final imageUrls = [
      'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=300&h=300&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?q=80&w=300&h=300&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1594824476967-48c8b964273f?q=80&w=300&h=300&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=300&h=300&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1537368910025-700350fe46c7?q=80&w=300&h=300&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1642391324626-7583f5d9696c?q=80&w=300&h=300&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1651008376397-84c60dd87a90?q=80&w=300&h=300&auto=format&fit=crop'
    ];

    return imageUrls[hash % imageUrls.length];
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