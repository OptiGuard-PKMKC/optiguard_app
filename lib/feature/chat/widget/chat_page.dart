import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optiguard/feature/chat/model/chat_item.dart';
import 'package:optiguard/feature/chat/provider/chat_provider.dart';
import 'package:optiguard/feature/chat/widget/chat_item_widget.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends ConsumerState<ChatPage> {
  late List<ChatItem> chatItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: 'Pesan',
        route: ChatRoute.path,
      ),
      body: _widgetContent(context),
    );
  }

  Widget _widgetContent(BuildContext context) {
    final chatNotifier = ref.read(chatNotifierProvider.notifier);

    chatItems = chatNotifier.fetchChatItems();
    // chatItems = [];

    return chatItems.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Kamu belum memiliki pesan',
                  textAlign: TextAlign.center),
            ),
          )
        : SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                for (int index = 0; index < chatItems.length; index++)
                  ChatItemWidget(chatItem: chatItems[index]),
              ],
            ),
          );
  }
}
