// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter

import 'package:flutter/material.dart';
import 'package:optiguard/app/widget/app_start_page.dart';
import 'package:optiguard/feature/appointment/widget/appointment_page.dart';
import 'package:optiguard/feature/auth/widget/sign_in_page.dart';
import 'package:optiguard/feature/auth/widget/sign_up_page.dart';
import 'package:optiguard/feature/doctor_profile/widget/doctor_profile_page.dart';
import 'package:optiguard/feature/fundus_capture/widget/fundus_capture_page.dart';
import 'package:optiguard/feature/home/widget/home_page.dart';
import 'package:optiguard/feature/home_doctor/widget/home_doctor_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _key = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@riverpod
GoRouter router(RouterRef ref) {
  //final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: _key,
    //refreshListenable: notifier,
    debugLogDiagnostics: true,
    initialLocation: AppRoute.path,
    routes: $appRoutes,
    //redirect: notifier.redirect,
  );
}

@TypedGoRoute<AppRoute>(path: AppRoute.path)
class AppRoute extends GoRouteData {
  const AppRoute();

  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppStartPage();
  }
}

@TypedGoRoute<HomeRoute>(path: HomeRoute.path)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const path = '/home';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@TypedGoRoute<HomeDoctorRoute>(path: HomeDoctorRoute.path)
class HomeDoctorRoute extends GoRouteData {
  const HomeDoctorRoute();

  static const path = '/homeDoctor';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeDoctorPage();
  }
}

@TypedGoRoute<FundusCaptureRoute>(path: FundusCaptureRoute.path)
class FundusCaptureRoute extends GoRouteData {
  const FundusCaptureRoute();
  static const path = '/fundusCapture';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FundusCapturePage();
  }
}

@TypedGoRoute<AppointmentRoute>(path: AppointmentRoute.path)
class AppointmentRoute extends GoRouteData {
  const AppointmentRoute();
  static const path = '/appointment';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentPage();
  }
}

@TypedGoRoute<DoctorProfileRoute>(path: DoctorProfileRoute.path)
class DoctorProfileRoute extends GoRouteData {
  const DoctorProfileRoute();
  static const path = '/doctorProfile';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DoctorProfilePage();
  }
}

@TypedGoRoute<SignInRoute>(path: SignInRoute.path)
class SignInRoute extends GoRouteData {
  const SignInRoute();

  static const path = '/signIn';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SignInPage();
  }
}

@TypedGoRoute<SignUpRoute>(path: SignUpRoute.path)
class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  static const path = '/signUp';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SignUpPage();
  }
}

class GoNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('did push route ${route} : ${previousRoute}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('did pop route ${route} : ${previousRoute}');
  }
}
