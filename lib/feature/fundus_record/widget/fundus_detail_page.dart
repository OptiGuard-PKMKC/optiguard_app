import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/util/global.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class FundusDetailPage extends ConsumerStatefulWidget {
  const FundusDetailPage({
    super.key,
    this.condition,
    this.image,
    this.isVerified = false,
    this.date,
  });

  final String? condition;
  final File? image;
  final bool isVerified;
  final DateTime? date;

  @override
  FundusDetailPageState createState() => FundusDetailPageState();
}

class FundusDetailPageState extends ConsumerState<FundusDetailPage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar:  const CustomAppBar(
          title: 'Hasil Funduskopi',
        ),
        body: _widgetContent(context, ref,
            condition: widget.condition, image: widget.image));
  }

  Widget _widgetContent(BuildContext context, WidgetRef ref,
      {String? condition, File? image}) {

    String date = DateTime.now().toString();    
    // Format the date to "day name, date"
    String formattedDate =
        DateFormat('EEEE, d MMMM y', "id").format(widget.date ?? DateTime.parse(date));
    // Format the time separately
    String formattedTime = DateFormat('HH:mm', "id").format(widget.date ?? DateTime.parse(date));

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image fundus
            Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: image != null
                        ? Image.file(image)
                        : Image.asset(
                            'assets/images/fundus_example.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.date_range_rounded),
                    const SizedBox(width: 8),
                    Text(formattedDate),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time_rounded),
                    const SizedBox(width: 8),
                    Text(formattedTime),
                  ],
                )
              ],
            ),

            const SizedBox(height: 16),

            // Prediction result
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hasil Prediksi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    condition != null
                        ? "Terindikasi ${getConditionName(condition)}"
                        : 'Tidak diketahui',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Feedback from doctor
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            widget.isVerified
                                ? Icons.verified_rounded
                                : Icons.pending,
                            color: widget.isVerified
                                ? AppColors.blue
                                : Colors.orange,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.isVerified
                                ? 'Sudah diverifikasi oleh dokter'
                                : 'Belum diverifikasi oleh dokter',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 32,
                    color: Colors.grey[200],
                  ),
                  if (widget.isVerified)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Feedback Dokter',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Funduskopi Anda terlihat normal. Silahkan konsultasikan hasil ini dengan dokter mata terdekat.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        const Text(
                            'Minta verifikasi dokter profesional untuk memastikan hasil deteksi aplikasi valid'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Call API to verify fundus result
                            // Dialog modal to show confirmation verify has been sent
                            _showConfirmationDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: const Size(double.infinity, 40),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: AppColors.blue,
                          ),
                          child: const Text(
                            'Verifikasi Hasil',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
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

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Konfirmasi',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Permintaan verifikasi fundus telah dikirim.',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}


