enum MessageStatus { sent, delivered, read }

class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageStatus status;

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.timestamp,
    this.status = MessageStatus.sent,
  });
}