import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/feature/fundus_capture/provider/fundus_history_provider.dart';
import 'package:optiguard/feature/fundus_record/widget/fundus_detail_page.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/http/api_provider.dart';
import 'package:optiguard/shared/util/db_loader.dart';
import 'package:optiguard/shared/util/snackbar.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

final loadingProvider = StateProvider<bool>((ref) => false);

class FundusImagePage extends ConsumerStatefulWidget {
  const FundusImagePage({
    Key? key,
    required this.userId,
    required this.imagePath,
  }) : super(key: key);

  final int userId;
  final String imagePath;

  @override
  _FundusImagePageState createState() => _FundusImagePageState();
}

class _FundusImagePageState extends ConsumerState<FundusImagePage> {
  late Future<File> _imageFileFuture;

  @override
  void initState() {
    super.initState();
    _imageFileFuture = _loadImage(widget.imagePath);
  }

  Future<File> _loadImage(String path) async {
    // Simulate a delay for loading the image (optional)
    await Future.delayed(Duration(seconds: 1));
    return File(path);
  }

  @override
  Widget build(BuildContext context) {
    final isLoadingDetection = ref.watch(loadingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleWidget: Image.asset(
          'assets/app_logo_xs.png',
          width: 32,
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            FutureBuilder<File>(
              future: _loadImage(widget.imagePath),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show loading indicator while the image is being loaded
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Handle any errors that occurred during image loading
                  return Center(child: Text('Error loading image'));
                } else if (snapshot.hasData) {
                  // Display the image once it's loaded
                  return Image.file(snapshot.data!);
                } else {
                  return Center(child: Text('No image found'));
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 40),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.blue),
                          ),
                        ),
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          'Kembali',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: AppColors.green,
                        ),
                        onPressed: isLoadingDetection
                            ? null
                            : () async {
                                // Implement your submit logic here
                                ref.read(loadingProvider.notifier).state = true;

                                showTopSnackBar(
                                    context, 'Deteksi sedang diproses', null);

                                // Call detection API
                                File image = File(widget.imagePath);

                                final detectResponse = await ref
                                    .read(apiProvider)
                                    .upload('/fundus/detect', image);

                                log(detectResponse.toString());
                                await detectResponse.when(success: (res) async {
                                  // Hide loading indicator
                                  ref.read(loadingProvider.notifier).state =
                                      false;

                                  final data;
                                  if (res["data"] != null) {
                                    data = res["data"] as Map<String, dynamic>;
                                  } else {
                                    data = null;
                                  }
                                  final message = res["message"] as String;

                                  // Handle success response here
                                  if (data == null) {
                                    showTopSnackBar(
                                        context, message, Colors.red[700]);
                                    return;
                                  }

                                  final String condition =
                                      data["condition"] as String;
                                  final bool verified =
                                      data["verified"] as bool;
                                  final DateTime createdAt = DateTime.parse(
                                      data["created_at"] as String);

                                  // Save image base64 to new file
                                  final imageBase64 =
                                      data["image_blob"] as String;
                                  final imageBytes = base64Decode(imageBase64);
                                  final newImagePath = widget.imagePath
                                      .replaceAll('.jpg', '_detected.jpg');
                                  final newImage = File(newImagePath);
                                  await newImage.writeAsBytes(imageBytes);

                                  // Save image to local database
                                  final dbLoader = ref.read(dbLoadProvider);
                                  await dbLoader.insertImage(
                                      widget.userId,
                                      newImagePath,
                                      verified,
                                      'pending',
                                      condition,
                                      createdAt);

                                  ref.invalidate(fundusHistoryNotifierProvider);

                                  await Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FundusDetailPage(
                                                condition: condition,
                                                image: newImage,
                                                isVerified: verified,
                                                date: createdAt,
                                              )));
                                }, error: (error) {
                                  // Hide loading indicator
                                  ref.read(loadingProvider.notifier).state =
                                      false;
                                  showTopSnackBar(context,
                                      'Deteksi fundus gagal', Colors.red[700]);
                                });
                              },
                        child: isLoadingDetection
                            ? SizedBox(
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                                height: 20,
                                width: 20,
                              )
                            : const Text(
                                'Deteksi',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
