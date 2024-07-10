import 'package:flutter/material.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/widget/app_bar.dart';
import 'package:optiguard/shared/widget/card_feature.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MainAppBar(
        title: 'Jadwal Saya',
        route: '/schedule',
      ),
      body: _widgetContent(context),
    );
  }

  Widget _widgetContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          InkWell(
              onTap: () {},
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
                        const Text(
                          'Atur Jadwal Saya',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
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
              )),
          const SizedBox(height: 16),
          Container(
            height: 60,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Item $index',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
