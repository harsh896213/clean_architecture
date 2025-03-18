class Chat {
  final String id;
  final List<String> participantIds;
  final DateTime lastActivity;
  final String? lastMessage;
  final DateTime createdAt;

  Chat({
    required this.id,
    required this.participantIds,
    required this.lastActivity,
    this.lastMessage,
    required this.createdAt,
  });
}