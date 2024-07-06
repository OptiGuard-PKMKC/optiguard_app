import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      appBar: MainAppBar(
        title: 'Rekam Medis',
        route: MedicalRecordRoute.path,
      ),
      body: Center(
        child: Text('My Widget'),
      ),
    );
  }
}
