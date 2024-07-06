// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter

import 'package:flutter/material.dart';
import 'package:optiguard/app/widget/app_start_page.dart';
import 'package:optiguard/app/widget/main_page.dart';
import 'package:optiguard/feature/appointment/widget/appointment_page.dart';
import 'package:optiguard/feature/auth/widget/sign_in_page.dart';
import 'package:optiguard/feature/auth/widget/sign_up_page.dart';
import 'package:optiguard/feature/chat/widget/chat_page.dart';
import 'package:optiguard/feature/chat/widget/chat_room_page.dart';
import 'package:optiguard/feature/doctor_profile/widget/doctor_profile_page.dart';
import 'package:optiguard/feature/education/widget/education_page.dart';
import 'package:optiguard/feature/fundus_capture/widget/fundus_capture_page.dart';
import 'package:optiguard/feature/fundus_capture/widget/fundus_image_page.dart';
import 'package:optiguard/feature/fundus_record/widget/fundus_detail_page.dart';
import 'package:optiguard/feature/home/widget/home_page.dart';
import 'package:optiguard/feature/home_doctor/widget/home_doctor_page.dart';
import 'package:go_router/go_router.dart';
import 'package:optiguard/feature/medical_record/widget/medical_record_detail_page.dart';
import 'package:optiguard/feature/medical_record/widget/medical_record_page.dart';
import 'package:optiguard/feature/profile/widget/profile_page.dart';
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

/**
 * App Routes
 */
@TypedGoRoute<AppRoute>(path: AppRoute.path)
class AppRoute extends GoRouteData {
  const AppRoute();

  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppStartPage();
  }
}

@TypedGoRoute<MainRoute>(path: MainRoute.path)
class MainRoute extends GoRouteData {
  const MainRoute();

  static const path = '/mainPatient';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainPatientPage();
  }
}

@TypedGoRoute<MainDoctorRoute>(path: MainDoctorRoute.path)
class MainDoctorRoute extends GoRouteData {
  const MainDoctorRoute();

  static const path = '/mainDoctor';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainDoctorPage();
  }
}

/**
 * Feature Routes
 */
@TypedGoRoute<AppointmentRoute>(path: AppointmentRoute.path)
class AppointmentRoute extends GoRouteData {
  const AppointmentRoute();
  static const path = '/appointment';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentPage();
  }
}

@TypedGoRoute<ChatRoute>(path: ChatRoute.path)
class ChatRoute extends GoRouteData {
  const ChatRoute();
  static const path = '/chat';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChatPage();
  }
}

@TypedGoRoute<ChatRoomRoute>(path: ChatRoomRoute.path)
class ChatRoomRoute extends GoRouteData {
  const ChatRoomRoute();
  static const path = '/chatRoom';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChatRoomPage();
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

@TypedGoRoute<EducationRoute>(path: EducationRoute.path)
class EducationRoute extends GoRouteData {
  const EducationRoute();
  static const path = '/education';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EducationPage();
  }
}

@TypedGoRoute<FundusCaptureRoute>(path: FundusCaptureRoute.path)
class FundusCaptureRoute extends GoRouteData {
  const FundusCaptureRoute();
  static const path = '/fundusCapture';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FundusCapturePage();
  }
}

@TypedGoRoute<FundusDetailRoute>(path: FundusDetailRoute.path)
class FundusDetailRoute extends GoRouteData {
  const FundusDetailRoute();
  static const path = '/fundusDetail';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FundusDetailPage();
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

@TypedGoRoute<MedicalRecordRoute>(path: MedicalRecordRoute.path)
class MedicalRecordRoute extends GoRouteData {
  const MedicalRecordRoute();
  static const path = '/medicalRecord';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MedicalRecordPage();
  }
}

@TypedGoRoute<MedicalRecordDetailRoute>(path: MedicalRecordDetailRoute.path)
class MedicalRecordDetailRoute extends GoRouteData {
  const MedicalRecordDetailRoute();
  static const path = '/medicalRecordDetail';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MedicalRecordDetailPage();
  }
}

@TypedGoRoute<ProfileRoute>(path: ProfileRoute.path)
class ProfileRoute extends GoRouteData {
  const ProfileRoute();
  static const path = '/profile';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfilePage();
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
