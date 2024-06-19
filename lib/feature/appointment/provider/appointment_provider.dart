import 'package:flutter_boilerplate/feature/appointment/state/appointment_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_provider.g.dart';

@riverpod
class AppointmentNotifier extends _$AppointmentNotifier {
  @override
  AppointmentState build() {
    return const AppointmentState.loading();
  }

  void loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      const data = 'Data loaded';
      state = const AppointmentState.loaded(data);
    } catch (e) {
      state = const AppointmentState.error('Failed to load data');
    }
  }
}
