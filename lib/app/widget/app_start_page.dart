import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optiguard/app/provider/app_start_provider.dart';
import 'package:optiguard/app/widget/main_page.dart';
import 'package:optiguard/feature/auth/widget/sign_in_page.dart';
import 'package:optiguard/shared/constants/role.dart';
import 'package:optiguard/shared/widget/connection_unavailable_widget.dart';
import 'package:optiguard/shared/widget/loading_widget.dart';
import 'package:optiguard/shared/widget/splash_page.dart';

class AppStartPage extends ConsumerWidget {
  const AppStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStartNotifierProvider);

    return state.when(
      data: (data) {
        return data.maybeWhen(
          initial: SplashPage.new,
          authenticated: (role) {
            if (role == Role.doctor) {
              return const MainDoctorPage();
            } else {
              return const MainPatientPage();
            }
          },
          unauthenticated: SignInPage.new,
          internetUnAvailable: () => const ConnectionUnavailableWidget(),
          orElse: () => const LoadingWidget(),
        );
      },
      error: (e, st) => const LoadingWidget(),
      loading: () => const LoadingWidget(),
    );
  }
}
