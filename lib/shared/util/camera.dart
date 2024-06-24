import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraStateProvider = Provider((ref) => CameraState());

class CameraState extends ChangeNotifier {
  late List<CameraDescription> _cameras;

  List<CameraDescription> get cameras => _cameras;

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    notifyListeners();
  }
}
