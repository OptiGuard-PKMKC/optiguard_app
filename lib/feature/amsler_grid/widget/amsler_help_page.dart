
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:optiguard/shared/widget/app_bar.dart';
import 'package:optiguard/shared/widget/button.dart';

class AmslerHelpPage extends StatelessWidget {
  const AmslerHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      appBar: const CustomAppBar(
        title: 'Panduan Asesmen Mandiri',
        backgroundColor: Colors.transparent,
        iconColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: _widgetContent(context),
      bottomSheet: _bottomSheetContent(context),
    );
  }

  Widget _widgetContent(BuildContext context) {
    final List<String> list = [
      'Pegang HP sejauh 12-15 inch dari pandangan',
      'Tutup satu mata, sehingga yang terbuka hanya mata yang ingin dicek',
      'Tatap titik tengah dari grid amsler',
      'Sembari menatap titik tengah, perhatikan garis kisi',
    ];

    Widget listItem(int num, String label) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Text(
                num.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 200,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset('assets/images/amsler_help.png',
                  fit: BoxFit.cover)),
          const SizedBox(height: 16),
          Column(
            children: List.generate(
              list.length,
              (index) => listItem(index + 1, list[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomSheetContent(BuildContext context) {
    return Container(
      color: AppColors.green,
      padding: const EdgeInsets.all(16),
      child: CustomElevatedButton(
        title: 'Mulai Asesmen Mandiri',
        color: Colors.white,
        textColor: AppColors.blue,
        onPressed: () {
          context.push(AmslerTestRoute.path);
        },
      ),
    );
  }
}
