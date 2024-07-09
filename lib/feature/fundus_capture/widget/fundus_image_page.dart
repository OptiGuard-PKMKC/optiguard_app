import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/util/snackbar.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

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
    return Scaffold(
      backgroundColor: Colors.black,
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
                padding: const EdgeInsets.all(16.0),
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
                        onPressed: () {
                          // Implement your submit logic here
                          showTopSnackBar(context, 'Prediksi sedang diproses');
                        },
                        child: Text(
                          'Prediksi',
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
