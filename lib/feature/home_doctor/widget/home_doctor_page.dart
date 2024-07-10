import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:optiguard/feature/home_doctor/provider/home_provider.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/shared/widget/app_bar.dart';
import 'package:optiguard/shared/widget/card_feature.dart';

class HomeDoctorPage extends ConsumerWidget {
  const HomeDoctorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MainAppBar(
        userName: 'dokter',
      ),
      body: _widgetContent(context, ref),
    );
  }

  Widget _widgetLoading(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('loading'.tr()),
    );
  }

  Widget _widgetContent(BuildContext context, WidgetRef ref) {
    // final state = ref.watch(booksNotifierProvider);

    // return state.when(
    //   loading: () {
    //     return _widgetLoading(context, ref);
    //   },
    //   booksLoaded: (books) {
    //     return ListView.builder(
    //         itemCount: books.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return RowBookWidget(book: books[index]);
    //         });
    //   },
    //   error: (AppException error) {
    //     return _widgetLoading(context, ref);
    //   },
    // );

    final homeState = ref.watch(homeNotifierProvider);

    return homeState.when(
      loading: () => _widgetLoading(context, ref),
      loaded: (data) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // _bodyBanner(context, ref),
            _bodyMainFeatures(context, ref),
            _bodyAppointment(context, ref),
            // Text(data),
          ],
        ),
      ),
      error: (message) => Center(
        child: Text(message),
      ),
    );
  }

  Widget _bodyBanner(BuildContext ctx, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 124,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 328,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text('Banner ${index + 1} '),
            ),
          );
        },
      ),
    );
  }

  Widget _bodyMainFeatures(BuildContext ctx, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: const Column(
        children: [
          Row(
            children: [
              CardFeature(
                title: 'Foto Fundus',
                icon: Icons.camera_alt,
                route: FundusCaptureRoute.path,
                subTitle: 'Ambil foto fundus untuk melihat kesehatan mata',
              ),
              SizedBox(width: 16),
              CardFeature(
                title: 'Pasien Saya',
                icon: Icons.device_hub,
                route: PatientRoute.path,
                bgIconColor: AppColors.green,
                subTitle: '2 pasien',
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _bodyAppointment(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Janji Temu',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Lihat Semua')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            alignment: Alignment.center,
            height: 120,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 328,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tiara Sabrina',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.pin_drop,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      Text('Senin, 12 Agustus 2024'),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text('08.00 - 10.00'),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
