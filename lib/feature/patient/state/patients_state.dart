import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optiguard/feature/patient/model/patient.dart';

part 'patients_state.freezed.dart';

@freezed
class PatientsState with _$PatientsState {
  const factory PatientsState.loading() = _Loading;
  const factory PatientsState.loaded(List<Patient> data) = _Loaded;
  const factory PatientsState.error(String message) = _Error;
}

@freezed
class PatientDetailState with _$PatientDetailState {
  const factory PatientDetailState.loading() = _LoadingDetail;
  const factory PatientDetailState.loaded(Patient data) = _LoadedDetail;
  const factory PatientDetailState.error(String message) = _ErrorDetail;
}
