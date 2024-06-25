import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:optiguard/app/app.dart';
import 'package:optiguard/shared/util/camera.dart';
import 'package:optiguard/shared/util/logger.dart';
import 'package:optiguard/shared/util/platform_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> start() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final cameraState = CameraState();
  await cameraState.initializeCamera();

  final platformType = detectPlatformType();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: ProviderScope(
        overrides: [
          cameraStateProvider.overrideWithValue(cameraState),
          platformTypeProvider.overrideWithValue(platformType),
        ],
        observers: [
          Logger(),
        ],
        child: const App(),
      ),
    ),
  );
}
