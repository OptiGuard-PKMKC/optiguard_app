import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_profile_state.freezed.dart';

@freezed
class DoctorProfileState with _$DoctorProfileState {
  const factory DoctorProfileState.loading() = _Loading;
  const factory DoctorProfileState.loaded(String data) = _Loaded;
  const factory DoctorProfileState.error(String message) = _Error;
}
