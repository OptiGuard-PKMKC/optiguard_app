import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class AmslerSuccessPage extends StatelessWidget {
  const AmslerSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: const CustomAppBar(
        backgroundColor: AppColors.blue,
        title: 'Hasil Asesmen Mandiri',
        titleTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        iconColor: Colors.white,
      ),
      body: _widgetContent(context),
    );
  }

  Widget _widgetContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 280,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.asset('assets/images/amsler_success.png'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Hore! Tidak ada masalah yang berarti pada mata Anda',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go(MainPatientRoute.path);
              },
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}
