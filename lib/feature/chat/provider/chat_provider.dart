import 'package:optiguard/feature/chat/model/chat_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_provider.g.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier {
  @override
  Future<List<ChatItem>> build() async {
    return fetchChatItems();
  }

  List<ChatItem> fetchChatItems() {
    final List<ChatItem> chatList = [
      ChatItem(
          chatId: '1hakdhad',
          name: 'dr. Grimaldi Ihsam, Sp.M',
          message:
              'Mata Anda terlihat sehat, tetap jaga kesehatan mata Anda dengan mengonsumsi makanan yang bergizi dan hindari paparan sinar UV',
          time: '10:00',
          avatarUrl: 'assets/avatar_dokter.jpg',
          isRead: false),
      ChatItem(
          chatId: 'adkjha9d',
          name: 'dr. Priscil, Sp.M',
          message:
              'Mata Anda terlihat sehat, tetap jaga kesehatan mata Anda dengan mengonsumsi makanan yang bergizi dan hindari paparan sinar UV',
          time: '10:00',
          avatarUrl: 'assets/avatar_dokter.jpg',
          isRead: false),
    ];

    return chatList;
  }
}
