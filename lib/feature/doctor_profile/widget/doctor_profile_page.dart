import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:optiguard/feature/home/provider/home_provider.dart';
import 'package:optiguard/feature/home/widget/row_book_widget.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/http/app_exception.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DoctorProfilePage extends ConsumerWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        toolbarHeight: 64,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: () {},
          ),
        ],
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
    final homeState = ref.watch(homeNotifierProvider);

    return homeState.when(
      loading: () => _widgetLoading(context, ref),
      loaded: (data) => Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Dr. John Doe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Dokter Spesialis Mata',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text('STR: 1234567890'),
              ],
            ),
          ),
          DraggableScrollableSheet(
              snap: true,
              initialChildSize: 0.6,
              minChildSize: 0.6,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            width: 60,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            )),
                        DefaultTabController(
                            length: 2,
                            child: Expanded(
                              child: Column(
                                children: [
                                  TabBar(
                                    tabs: const [
                                      Tab(text: 'Jadwal'),
                                      Tab(text: 'Profil Lengkap')
                                    ],
                                    dividerHeight: 1,
                                    dividerColor: Colors.grey[300],
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            children: [
                                              // _scheduleDate(),
                                              _listSchedule(context, ref),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: _profilDetail(
                                              context, scrollController),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ));
              })
        ],
      ),
      error: (message) => Center(
        child: Text(message),
      ),
    );
  }

  Widget _profilDetail(
      BuildContext context, ScrollController parentController) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notif) {
        if (notif.extent == notif.minExtent) {
          parentController.jumpTo(parentController.position.minScrollExtent);
        }
        return true;
      },
      child: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          const ProfileDetailItem(
              title: 'BIO',
              content: Text(
                  'Saya adalah dokter spesialis mata dengan pengalaman lebih dari 5 tahun di bidang oftalmologi. Saya berdedikasi untuk memberikan perawatan terbaik kepada pasien dengan berbagai kondisi mata.')),
          Divider(
            thickness: 1,
            color: Colors.grey[300],
            height: 32,
          ),
          const ProfileDetailItem(
            title: 'PENGALAMAN PRAKTIK',
            content: Text('Rumah Sakit Mata A'),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[300],
            height: 32,
          ),
          const ProfileDetailItem(
            title: 'PENDIDIKAN',
            content: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Universitas Telkom',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text('Dokter Umum'),
                    Text('2010 - 2016'),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Universitas Telkom',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text('Dokter Umum'),
                    Text('2010 - 2016'),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Universitas Telkom',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text('Dokter Umum'),
                    Text('2010 - 2016'),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _listSchedule(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Text('Jadwal ke $index');
        },
      ),
    );
  }
}

class ProfileDetailItem extends StatelessWidget {
  const ProfileDetailItem({
    required this.title,
    required this.content,
    super.key,
  });

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        content,
      ],
    );
  }
}
