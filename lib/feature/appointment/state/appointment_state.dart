import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_state.freezed.dart';

@freezed
class AppointmentState with _$AppointmentState {
  const factory AppointmentState.loading() = _Loading;
  const factory AppointmentState.loaded(String data) = _Loaded;
  const factory AppointmentState.error(String message) = _Error;
}
