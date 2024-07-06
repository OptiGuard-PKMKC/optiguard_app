import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optiguard/feature/chat/model/chat_room.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  const ChatRoomPage({super.key, this.chatId = ''});

  final String chatId;

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleWidget: Row(
          children: [
            CircleAvatar(),
            const SizedBox(width: 8),
            Text('dr. Any', style: TextStyle(fontSize: 16))
          ],
        ),
      ),
      body: _widgetContent(context),
      bottomSheet: _bottomSheetInput(context),
    );
  }

  Widget _widgetContent(BuildContext context) {
    final List<Message> messages = [
      Message('dr. Any', 'sakans adkasda doaisdjoada', DateTime.now()),
      Message('dr. Any', 'sakans adkasd', DateTime.now())
    ];

    return Container(
      margin: EdgeInsets.only(bottom: 64),
      padding: EdgeInsets.all(16),
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];
                return ListTile(
                  title: Text(message.user),
                  subtitle: Text(message.message),
                  trailing: Text(
                    "${message.timestamp.hour}:${message.timestamp.minute}",
                    style: TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomSheetInput(BuildContext context) {
    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
        color: Colors.grey[300]!,
      ))),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: 'Ketik pesan...',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.newline,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // final message = ChatMessage(
              //   user: 'User',
              //   message: _inputController.text,
              //   timestamp: DateTime.now(),
              // );
              // ref.read(chatProvider.notifier).addMessage(message);
              _inputController.clear();
            },
          ),
        ],
      ),
    );
  }
}
