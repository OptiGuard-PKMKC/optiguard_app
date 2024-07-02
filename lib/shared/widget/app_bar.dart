import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.onLeadingPressed,
    this.leadingIcon = Icons.arrow_back_rounded,
    this.backgroundColor = Colors.white,
    this.titleTextStyle = const TextStyle(fontSize: 16),
    this.titleSpacing = 0,
  });

  final String title;
  final VoidCallback? onLeadingPressed;
  final IconData leadingIcon;
  final Color backgroundColor;
  final TextStyle titleTextStyle;
  final double titleSpacing;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title, style: titleTextStyle),
      titleSpacing: titleSpacing,
      leading: IconButton(
        icon: Icon(leadingIcon),
        onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
