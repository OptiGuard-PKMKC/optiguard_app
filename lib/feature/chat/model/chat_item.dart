class ChatItem {
  ChatItem({
    required this.chatId,
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    required this.isRead,
  });
  
  final String chatId;
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final bool isRead;
}
