import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/feature/home/provider/home_provider.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MainAppBar(),
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
            _bodyBanner(context, ref),
            _bodyMainFeatures(context, ref),
            _bodyAppointment(context, ref),
            _bodyAdaptor(context, ref),
            _bodyArticle(context, ref),
            Text(data),
          ],
        ),
      ),
      error: (message) => Center(
        child: Text(message),
      ),
    );
  }

  Widget _bodyBanner(BuildContext ctx, WidgetRef ref) {
    final List<String> banners = [
      'assets/banner_01.png',
      'assets/banner_02.png',
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 124,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            width: 328,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: AssetImage(banners[index]), fit: BoxFit.cover)),
          );
        },
      ),
    );
  }

  Widget _bodyMainFeatures(BuildContext ctx, WidgetRef ref) {
    Widget cardRow(
      String title,
      String subTitle,
      IconData icon,
      Color bgIconColor,
      String? route,
    ) {
      return Expanded(
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.1),
          highlightColor: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (route != null) {
              ctx.push(route);
            }
          },
          child: Ink(
            padding: const EdgeInsets.all(16),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: bgIconColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(
                    icon,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  subTitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              cardRow(
                'Foto Fundus',
                'Ambil foto fundus untuk melihat kesehatan mata',
                Icons.camera_alt,
                AppColors.blue,
                FundusCaptureRoute.path,
              ),
              const SizedBox(width: 16),
              cardRow(
                'Akses Alat di Faskes',
                'Pakai alat yang tersedia di mitra kami',
                Icons.device_hub,
                AppColors.green,
                null,
              ),
            ],
          ),
          const SizedBox(height: 32),
          InkWell(
            onTap: () {
              ctx.push(AppointmentRoute.path);
            },
            splashColor: Colors.teal.withOpacity(0.3),
            highlightColor: Colors.teal.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            child: Ink(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Icon(
                            Icons.medical_services,
                            size: 32,
                            color: AppColors.green,
                          )),
                      const SizedBox(width: 16),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jadwal Dokter',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Lihat jadwal dokter dan buat janji',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 32,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
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
                                    'dr. Rudi',
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
                                      Text('Senin, 12 Juli 2021'),
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

  Widget _bodyAdaptor(BuildContext context, WidgetRef ref) {
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
                  'Jadwal Akses Alat',
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
                              const Text(
                                'Puskesmas Bojongsoang',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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
                        const Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 20,
                            ),
                            SizedBox(width: 4),
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

  Widget _bodyArticle(BuildContext context, WidgetRef ref) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Artikel Terbaru',
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
            height: 240,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
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
                              const Text(
                                'Puskesmas',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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
                        const Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 20,
                            ),
                            SizedBox(width: 4),
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
