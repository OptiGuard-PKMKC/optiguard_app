import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/feature/chat/model/chat_item.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({
    super.key,
    required this.chatItem,
  });

  final ChatItem chatItem;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // TODO: Add navigation to chat detail page
          context.push(ChatRoomRoute.path);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey[300]!,
                  ),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(chatItem.avatarUrl),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatItem.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      chatItem.message,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    chatItem.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          chatItem.isRead ? Colors.transparent : AppColors.green,
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
