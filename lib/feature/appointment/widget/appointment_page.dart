import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:optiguard/feature/home/provider/books_provider.dart';
import 'package:optiguard/feature/home/provider/home_provider.dart';
import 'package:optiguard/feature/home/widget/row_book_widget.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/http/app_exception.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppointmentPage extends ConsumerWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: AppColors.green,
          scrolledUnderElevation: 0,
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
          titleSpacing: 0,
          title: Row(children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20,
                    ),
                    hintText: 'Cari dokter',
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.7)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.filter_alt_outlined),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () {},
            ),
          ])),
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
      loaded: (data) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _bodyHero(context, ref),
            const SizedBox(height: 8),
            _bodyDoctorList(context, ref),
          ],
        ),
      ),
      error: (message) => Center(
        child: Text(message),
      ),
    );
  }

  Widget _bodyHero(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 100,
      decoration: const BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilih Dokter',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
              'Jadwalkan janji temu dengan dokter untuk menindaklanjuti hasil periksa mandiri di aplikasi.',
              style: TextStyle(color: Colors.white, fontSize: 14))
        ],
      ),
    );
  }

  Widget _bodyDoctorList(BuildContext context, WidgetRef ref) {
    Widget iconBadge(IconData icon, String text) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[700]),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    Widget cardDoctor() {
      return InkWell(
        onTap: () {
          context.push(DoctorProfileRoute.path);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Container(
                width: 116,
                height: 116,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dr. John Doe',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Text('Dokter Spesialis Mata'),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      iconBadge(Icons.work_history, '3 tahun'),
                      const SizedBox(width: 8),
                      iconBadge(Icons.star, '4.5'),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 32,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: const Text(
                          'Booking',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    final cardDoctors = <Widget>[];
    for (var i = 0; i < 10; i++) {
      cardDoctors.add(cardDoctor());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cardDoctors,
    );
  }
}
