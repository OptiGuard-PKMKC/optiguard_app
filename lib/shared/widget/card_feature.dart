import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/shared/constants/app_theme.dart';

class CardFeature extends StatelessWidget {
  const CardFeature(
      {super.key,
      required this.title,
      this.subTitle,
      required this.icon,
      this.bgIconColor = AppColors.blue,
      required this.route,
      this.height = 180});

  final String title;
  final String? subTitle;
  final IconData icon;
  final Color bgIconColor;
  final String route;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.push(route);
        },
        child: Ink(
          padding: const EdgeInsets.all(16),
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgIconColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700, height: 1.2),
              ),
              const SizedBox(height: 8),
              if (subTitle != null)
                Text(
                  subTitle!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
