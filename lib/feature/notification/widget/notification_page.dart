import 'package:flutter/material.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Notifikasi',
        ),
        body: _widgetContent(context));
  }

  Widget _widgetContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          'Belum ada notifikasi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
