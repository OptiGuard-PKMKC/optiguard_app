import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optiguard/feature/medical_record/widget/fundus_history_list.dart';
import 'package:optiguard/feature/medical_record/widget/medical_record_list.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class MedicalRecordPage extends ConsumerStatefulWidget {
  const MedicalRecordPage({super.key});

  @override
  MedicalRecordPageState createState() => MedicalRecordPageState();
}

class MedicalRecordPageState extends ConsumerState<MedicalRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MainAppBar(
        title: 'Rekam Medis',
        route: MedicalRecordRoute.path,
      ),
      body: Container(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const Material(
                color: Colors.white,
                child: TabBar(
                  tabs: [
                    Tab(text: 'Rekam Medis'),
                    Tab(text: 'Riwayat Fundus'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _tabMedicalRecord(),
                    _tabFundusHistory(),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  Widget _tabMedicalRecord() {
    return MedicalRecordList();
  }

  Widget _tabFundusHistory() {
    return FundusHistoryList();
  }
}
