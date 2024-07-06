import 'package:flutter/material.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class MedicalRecordDetailPage extends StatefulWidget {
  const MedicalRecordDetailPage({super.key});

  @override
  State<MedicalRecordDetailPage> createState() => _MedicalRecordDetailPageState();
}

class _MedicalRecordDetailPageState extends State<MedicalRecordDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
    );
  }
}