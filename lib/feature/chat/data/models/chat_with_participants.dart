class ChatWithParticipants {
  final String id;
  final DateTime lastActivity;
  final String? lastMessage;
  final DateTime createdAt;
  final List<String> participantIds;

  ChatWithParticipants({
    required this.id,
    required this.lastActivity,
    this.lastMessage,
    required this.createdAt,
    required this.participantIds,
  });

  factory ChatWithParticipants.fromMap(Map<String, dynamic> map) {
    return ChatWithParticipants(
      id: map['chatId'],
      lastActivity: DateTime.fromMillisecondsSinceEpoch(map['lastActivity']),
      lastMessage: map['lastMessage'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      participantIds: (map['participantIds'] as String).split(','),
    );
  }

  @override
  String toString() {
    return 'ChatWithParticipants(id: $id, lastActivity: $lastActivity, lastMessage: $lastMessage, createdAt: $createdAt, participantIds: $participantIds)';
  }
}