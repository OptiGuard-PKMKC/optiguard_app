import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class AmslerFailedPage extends StatelessWidget {
  const AmslerFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[800],
      appBar: CustomAppBar(
        backgroundColor: Colors.orange[800]!,
        title: 'Hasil Asesmen Mandiri',
        titleTextStyle: const TextStyle(
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
              child: Image.asset('assets/images/amsler_failed.png'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Sayang sekali terindikasi ada masalah pada retina mata Anda',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
                'Segera temui dokter untuk mendapatkan penanganan lebih lanjut!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center),
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
