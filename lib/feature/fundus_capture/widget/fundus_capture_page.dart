import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/feature/fundus_capture/provider/fundus_capture_provider.dart';
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

  @override
  void initState() {
    super.initState();

    final cameras = ref.read(cameraStateProvider).cameras;

    _cameraController = CameraController(
      cameras[_cameraIndex],
      ResolutionPreset.ultraHigh,
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
          )
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
                                child: GestureDetector(
                                  onTap: () {
                                    _changeShutterScale();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Take picture'),
                                        backgroundColor: Colors.redAccent,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  child: AnimatedScale(
                                    scale: shutterScale,
                                    duration: const Duration(milliseconds: 100),
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
                      SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              for (int index = 0; index < 5; index++)
                                InkWell(
                                  onTap: () {
                                    // context.go('/fundus/detail');
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        bottom:
                                            8), // Add spacing between items if needed
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'KONDISI',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black54),
                                                    ),
                                                    Text(
                                                      'Normal',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 12),
                                                Text(
                                                  '12/12/2021',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey[600]),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          icon: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                                Icons.more_horiz_rounded),
                                          ),
                                          onPressed: () {
                                            // context.go('/fundus/detail');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
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
