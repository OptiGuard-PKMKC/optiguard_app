import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optiguard/feature/fundus_capture/provider/fundus_capture_provider.dart';
import 'package:optiguard/feature/fundus_record/widget/fundus_history_list.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/util/camera.dart';

const double _kDraggableSize = 0.2;
const double _kMaxDraggableSize = 0.89;

class FundusCapturePage extends ConsumerStatefulWidget {
  const FundusCapturePage({super.key});

  @override
  FundusCapturePageState createState() => FundusCapturePageState();
}

class FundusCapturePageState extends ConsumerState<FundusCapturePage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  final int _cameraIndex = 0;
  FlashMode flashMode = FlashMode.off;

  XFile? _pickedImage;

  ValueNotifier<double> dragSizeNotifier = ValueNotifier<double>(0.2);
  double draggableSize = _kDraggableSize;

  double shutterScale = 1.0;

  void _changeShutterScale() {
    setState(() {
      shutterScale = shutterScale == 1.0 ? _kMaxDraggableSize : 1.0;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        shutterScale = 1.0;
      });
    });
  }

  void _changeFlashMode() {
    setState(() {
      if (flashMode == FlashMode.off) {
        flashMode = FlashMode.torch;
      } else {
        flashMode = FlashMode.off;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    final cameras = ref.read(cameraStateProvider).cameras;

    _cameraController = CameraController(
      cameras[_cameraIndex],
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 64,
        title: Container(
          padding: const EdgeInsets.only(right: 6, left: 6, bottom: 6, top: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/app_logo_xs.png',
            width: 32,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.arrow_back_rounded),
          ),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                alignment: Alignment.center,
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: flashMode == FlashMode.torch
                      ? AppColors.blue
                      : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.flash_on_rounded,
                    size: 18,
                    color: flashMode == FlashMode.torch
                        ? Colors.white
                        : Colors.black,
                  ),
                  onPressed: () {
                    _changeFlashMode();
                    ref
                        .read(fundusCaptureNotifierProvider.notifier)
                        .flashTorch(context, _cameraController, flashMode);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16),
                alignment: Alignment.center,
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.question_mark_rounded,
                    size: 16,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
      body: _widgetContent(
          context, ref, _cameraController, _initializeControllerFuture),
    );
  }

  Widget _widgetLoading(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('loading'.tr()),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = pickedFile;
      });
    }
  }

  Widget _widgetContent(
      BuildContext context,
      WidgetRef ref,
      CameraController cameraController,
      Future<void> initializeControllerFuture) {
    final fundusState = ref.watch(fundusCaptureNotifierProvider);

    return fundusState.when(
      loading: () => _widgetLoading(context, ref),
      loaded: (data) => Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              setState(() {
                draggableSize = notification.extent;
              });
              return true;
            },
            child: DraggableScrollableSheet(
              snap: true,
              initialChildSize: _kDraggableSize,
              minChildSize: _kDraggableSize,
              maxChildSize: _kMaxDraggableSize,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 170, vertical: 8),
                          width: MediaQuery.of(context).size.width - 200,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      if (draggableSize < 0.4)
                        // Circle shutter button
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                    right: 16, left: 16, top: 10, bottom: 16),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.image_rounded,
                                        size: 40,
                                        color: Colors.black87,
                                      ),
                                      onPressed: () {
                                        ref
                                            .read(fundusCaptureNotifierProvider
                                                .notifier)
                                            .pickImage(context);
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _changeShutterScale();

                                        // Take picture
                                        ref
                                            .read(fundusCaptureNotifierProvider
                                                .notifier)
                                            .captureImage(
                                                context, cameraController);

                                        setState(() {
                                          flashMode = FlashMode.off;
                                        });
                                      },
                                      child: AnimatedScale(
                                        scale: shutterScale,
                                        duration:
                                            const Duration(milliseconds: 100),
                                        child: Container(
                                          width: 64,
                                          height: 64,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.blue,
                                            border: Border.all(
                                              color: Colors.blue[100]!,
                                              width: 6,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.circle,
                                        size: 40,
                                        color: Colors.transparent,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                height: 0,
                                color: Colors.grey[200],
                              ),
                            ],
                          ),
                        ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: const BoxDecoration(
                            color: AppColors.green,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Riwayat Rekam Fundus',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.history_rounded,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),

                      // Fundus history list
                      const SliverToBoxAdapter(child: FundusHistoryList()),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      error: (message) => Center(
        child: Text(message),
      ),
    );
  }
}
