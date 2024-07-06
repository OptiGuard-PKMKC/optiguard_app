import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:optiguard/shared/widget/app_bar.dart';
import 'package:optiguard/shared/widget/button.dart';

class AmslerTestPage extends ConsumerStatefulWidget {
  const AmslerTestPage({super.key});

  @override
  _AmslerTestPageState createState() => _AmslerTestPageState();
}

class _AmslerTestPageState extends ConsumerState<AmslerTestPage> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Amsler Grid',
      ),
      body: _widgetContent(context),
      bottomSheet: _bottomSheetContent(context),
    );
  }

  Widget _widgetContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(bottom: 80),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/images/amsler_grid.png',
                    fit: BoxFit.contain)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    'Centang kotak jika keterangan sesuai dengan penglihatan',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Divider(
                    height: 24,
                    thickness: 1,
                    color: Colors.grey[300]!,
                  ),
                  Column(
                    children: [
                      _buildCheckboxRow('Garis kisi terlihat buram', isChecked1,
                          (value) {
                        setState(() {
                          isChecked1 = value!;
                        });
                      }),
                      _buildCheckboxRow(
                          'Garis kisi terlihat bergelombang', isChecked2,
                          (value) {
                        setState(() {
                          isChecked2 = value!;
                        });
                      }),
                      _buildCheckboxRow('Ada kotak yang hilang', isChecked3,
                          (value) {
                        setState(() {
                          isChecked3 = value!;
                        });
                      }),
                      _buildCheckboxRow(
                          'Terdapat area gelap/tertutup warna hitam',
                          isChecked4, (value) {
                        setState(() {
                          isChecked4 = value!;
                        });
                      }),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxRow(
      String labelText, bool isChecked, Function(bool?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              labelText,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _bottomSheetContent(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: CustomElevatedButton(
        title: 'Cek Hasil Saya',
        onPressed: () {
          if (!isChecked1 && !isChecked2 && !isChecked3 && !isChecked4) {
            context.push(AmslerSuccessRoute.path);
          } else {
            context.push(AmslerFailedRoute.path);
          }
        },
      ),
    );
  }
}
