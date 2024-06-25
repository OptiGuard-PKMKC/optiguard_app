import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optiguard/feature/fundus_capture/provider/fundus_capture_provider.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/util/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  double draggableSize = 0.2;

  double shutterScale = 1.0;

  void _changeShutterScale() {
    setState(() {
      shutterScale = shutterScale == 1.0 ? 0.9 : 1.0;
    });
    Future.delayed(Duration(milliseconds: 200), () {
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
      // body: FutureBuilder<void>(
      //   future: _initializeControllerFuture,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return CameraPreview(_cameraController);
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
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
              initialChildSize: 0.2,
              minChildSize: 0.2,
              maxChildSize: 0.9,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 170, vertical: 10),
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
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
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
                              height: 16,
                              thickness: 2,
                              color: Colors.grey[200],
                            ),
                          ],
                        ),
                      ),

                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return ListTile(
                              title: Text('item $index'),
                            );
                          },
                          childCount: 5,
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
