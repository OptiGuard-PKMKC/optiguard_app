import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.titleWidget,
    this.onLeadingPressed,
    this.leadingIcon = Icons.arrow_back_rounded,
    this.iconColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.titleTextStyle = const TextStyle(fontSize: 16),
    this.titleSpacing = 0,
  });

  final String title;
  final Widget? titleWidget;
  final VoidCallback? onLeadingPressed;
  final IconData leadingIcon;
  final Color iconColor;
  final Color backgroundColor;
  final TextStyle titleTextStyle;
  final double titleSpacing;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: backgroundColor,
      title: (titleWidget != null)
          ? titleWidget
          : Text(title, style: titleTextStyle),
      titleSpacing: titleSpacing,
      leading: IconButton(
        icon: Icon(
          leadingIcon,
          color: iconColor,
        ),
        onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, this.route = HomeRoute.path, this.title = ''});

  final String route;
  final String title;

  Icon _timeIcon() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) {
      return const Icon(
        Icons.wb_sunny,
        color: Colors.yellow,
        size: 36,
      );
    } else if (hour >= 11 && hour < 15) {
      return Icon(
        Icons.wb_sunny,
        color: Colors.yellow[700],
        size: 36,
      );
    } else if (hour >= 15 && hour < 18) {
      return Icon(
        Icons.nightlight_round,
        color: Colors.orange[700],
        size: 36,
      );
    } else {
      return Icon(
        Icons.nightlight_round,
        color: Colors.blue[700],
        size: 36,
      );
    }
  }

  String _timeGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) {
      return 'Selamat pagi,';
    } else if (hour >= 11 && hour < 15) {
      return 'Selamat siang,';
    } else if (hour >= 15 && hour < 18) {
      return 'Selamat sore,';
    } else {
      return 'Selamat malam,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      toolbarHeight: 64,
      title: (route == HomeRoute.path)
          ? Row(
              children: [
                _timeIcon(),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_timeGreeting(), style: const TextStyle(fontSize: 14)),
                    const Text(
                      'Tiara',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            )
          : Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications_rounded),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            context.push(ProfileRoute.path);
          },
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.green, width: 2),
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/avatar_example.png'),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
