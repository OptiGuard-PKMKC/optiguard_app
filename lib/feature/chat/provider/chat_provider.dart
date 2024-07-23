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
          name: 'dr. Grimaldi Ihsan, Sp.M',
          message:
              'Mata Anda terlihat sehat, tetap jaga kesehatan mata Anda dengan mengonsumsi makanan yang bergizi dan hindari paparan sinar UV',
          time: '10:00',
          avatarUrl: 'assets/avatar_dokter_2.png',
          isRead: false),
      ChatItem(
          chatId: 'adkjha9d',
          name: 'dr. Sonie Umbara, Sp.M',
          message:
              'Tetap jaga kesehatan mata Anda dengan mengonsumsi makanan yang bergizi dan hindari paparan sinar UV',
          time: '10:00',
          avatarUrl: 'assets/avatar_dokter_3.png',
          isRead: false),
    ];

    return chatList;
  }
}
