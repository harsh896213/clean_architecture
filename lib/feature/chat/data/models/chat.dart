class Chat {
  final String id;
  final DateTime lastActivity;
  final String? lastMessage;
  final DateTime createdAt;
  List<String> participantIds; // This will be populated separately

  Chat({
    required this.id,
    required this.lastActivity,
    this.lastMessage,
    required this.createdAt,
    this.participantIds = const [], // Initialize as empty list
  });

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'],
      lastActivity: DateTime.fromMillisecondsSinceEpoch(map['lastActivity']),
      lastMessage: map['lastMessage'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lastActivity': lastActivity.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
      'createdAt': createdAt.millisecondsSinceEpoch
    };
  }
}