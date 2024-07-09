import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:optiguard/feature/fundus_capture/state/fundus_capture_state.dart';
import 'package:optiguard/feature/fundus_capture/widget/fundus_image_page.dart';
import 'package:optiguard/shared/util/db_loader.dart';
import 'package:optiguard/shared/util/snackbar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fundus_capture_provider.g.dart';

@riverpod
class FundusCaptureNotifier extends _$FundusCaptureNotifier {
  @override
  FundusCaptureState build() {
    return const FundusCaptureState.loaded('Camera loaded');
  }

  Future<void> loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      const data = 'Data loaded';
      state = const FundusCaptureState.loaded(data);
    } catch (e) {
      state = const FundusCaptureState.error('Failed to load data');
    }
  }

  Future<void> flashTorch(
      BuildContext context, CameraController cameraController, FlashMode flashMode) async {
    try {
      if (!cameraController.value.isInitialized) {
        throw Exception('Camera is not initialized');
      }

      if (cameraController.value.flashMode != flashMode) {
        await cameraController.setFlashMode(flashMode);
      } else {
        await cameraController.setFlashMode(flashMode);
      }
    } catch (e) {
      state = const FundusCaptureState.error('Failed to capture image');
    }
  }

  Future<void> captureImage(
      BuildContext context, CameraController cameraController) async {
    try {
      if (!cameraController.value.isInitialized) {
        throw Exception('Camera is not initialized');
      }

      if (cameraController.value.isTakingPicture) {
        throw Exception('Camera is already taking picture');
      }

      final XFile file = await cameraController.takePicture();
      await cameraController.setFlashMode(FlashMode.off);
      final imagePath = file.path;

      DatabaseLoader dbLoader = DatabaseLoader();
      await dbLoader.insertImage(1, imagePath);

      // Notify user that image has been captured
      showTopSnackBar(context, 'Gambar fundus berhasil diambil!');

      // Navigate using material page route
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FundusImagePage(
          userId: 1,
          imagePath: imagePath,
        );
      }));

      print('Image captured: ${file.path}');
    } catch (e) {
      state = const FundusCaptureState.error('Failed to capture image');
    }
  }
}
