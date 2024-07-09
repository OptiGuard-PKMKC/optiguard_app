import 'package:flutter/material.dart';
import 'package:optiguard/feature/medical_record/widget/fundus_history_list.dart';
import 'package:optiguard/feature/medical_record/widget/medical_record_list.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class PatientDetailPage extends StatefulWidget {
  const PatientDetailPage({required this.patientId, super.key});

  final String patientId;

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Tiara Sabrina',
        ),
        body: _widgetContent(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your custom logic here
          },
          child: const Icon(Icons.add),
        ));
  }

  Widget _widgetContent(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const Material(
              color: Colors.white,
              child: TabBar(
                tabs: [
                  Tab(text: 'Riwayat Fundus'),
                  Tab(text: 'Rekam Medis'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _tabFundusHistory(),
                  _tabMedicalRecord(),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _tabMedicalRecord() {
    return MedicalRecordList();
  }

  Widget _tabFundusHistory() {
    return FundusHistoryList();
  }
}
