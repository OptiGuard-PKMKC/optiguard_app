import 'package:flutter/material.dart';
import 'package:optiguard/shared/constants/app_theme.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    this.icon = Icons.circle_rounded,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Make sure the splash color is visible
      child: InkWell(
        splashColor: Colors.grey.withAlpha(30),
        onTap: onTap,
        child: ListTile(
          leading: Icon(icon, color: AppColors.blue),
          title: Text(title, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
