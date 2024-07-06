import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optiguard/shared/constants/app_theme.dart';
import 'package:optiguard/shared/route/app_router.dart';
import 'package:optiguard/shared/widget/app_bar.dart';

class EducationPage extends ConsumerStatefulWidget {
  const EducationPage({super.key});

  @override
  EducationPageState createState() => EducationPageState();
}

class EducationPageState extends ConsumerState<EducationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MainAppBar(
        title: 'Edukasi',
        route: EducationRoute.path,
      ),
      body: Center(
        child: Text('My Widget'),
      ),
    );
  }
}
