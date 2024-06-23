
import 'package:flutter_boilerplate/feature/doctor_profile/state/doctor_profile_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'doctor_profile_provider.g.dart';

@riverpod
class DoctorProfileNotifier extends _$DoctorProfileNotifier {
  @override
  DoctorProfileState build() {
    return const DoctorProfileState.loading();
  }

  void loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      const data = 'Data loaded';
      state = const DoctorProfileState.loaded(data);
    } catch (e) {
      state = const DoctorProfileState.error('Failed to load data');
    }
  }
}
