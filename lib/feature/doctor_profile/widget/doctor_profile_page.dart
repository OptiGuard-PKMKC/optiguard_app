import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:optiguard/feature/home/provider/home_provider.dart';
import 'package:optiguard/feature/home/widget/row_book_widget.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/http/app_exception.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/shared/widget/button.dart';

class DoctorProfilePage extends ConsumerStatefulWidget {
  const DoctorProfilePage({super.key});

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends ConsumerState<DoctorProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    Widget iconBadge(IconData icon, Color? iconColor, String text) {
      var iColor = AppColors.blue;

      if (iconColor != null) {
        iColor = iconColor;
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: iColor),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54),
            ),
          ],
        ),
      );
    }

    return homeState.when(
      loading: () => _widgetLoading(context, ref),
      loaded: (data) => Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 132,
                  height: 132,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/avatar_dokter_2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'dr. Grimaldi Ihsan, Sp.M.',
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
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconBadge(Icons.work_history, null, '8 tahun'),
                    const SizedBox(width: 8),
                    iconBadge(Icons.star, Colors.orange, '4.8'),
                  ],
                ),
                // Text('STR: 1234567890'),
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
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 160),
                              width: double.infinity,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        SliverAppBar(
                          expandedHeight: 0,
                          elevation: 0,
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          leading: Container(),
                          pinned: true,
                          floating: true,
                          bottom: TabBar(
                            controller: _tabController,
                            tabs: [
                              Tab(text: 'Jadwal'),
                              Tab(text: 'Profil Lengkap'),
                            ],
                          ),
                        ),
                        SliverFillRemaining(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Container(
                                // width media query
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _scheduleDate(context, ref),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              '07.00 - 08.00',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              '08.00 - 09.00',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              '09.00 - 10.00',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              _profilDetail(context)
                            ],
                          ),
                        ),
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

  Widget _profilDetail(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            content: Text('Rumah Sakit Mata Cicendo'),
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
                      'Universitas Padjajaran',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text('Spesialis Mata'),
                    Text('2016 - 2018'),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Universitas Padjajaran',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text('Dokter Umum'),
                    Text('2010 - 2016'),
                  ],
                ),
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

  Widget _scheduleDate(BuildContext context, WidgetRef ref) {
    return Container(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            child: Icon(Icons.calendar_month_rounded),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 14,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${index + 1}',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '3 Jadwal',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  Widget _listSchedule(BuildContext context, WidgetRef ref) {
    return Column(
      children: [RowScheduleWidget()],
    );
  }
}

class RowScheduleWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Row(
            children: [Icon(Icons.timer_sharp), Text('08:00 - 09:00')],
          ),
          CustomElevatedButton(title: 'Pilih')
        ],
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
