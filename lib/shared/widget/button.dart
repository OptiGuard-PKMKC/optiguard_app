import 'package:flutter/material.dart';
import 'package:optiguard/shared/constants/app_theme.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    this.textColor = Colors.white,
    this.color = AppColors.blue,
    this.icon,
    this.iconColor = Colors.white,
    this.onPressed,
  });

  final String title;
  final Color textColor;
  final Color? color;
  final IconData? icon;
  final Color iconColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(double.infinity, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Transform.flip(
              flipX: true,
              child: Icon(icon, color: iconColor),
            ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
