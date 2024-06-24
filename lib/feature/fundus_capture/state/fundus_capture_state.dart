import 'package:freezed_annotation/freezed_annotation.dart';

part 'fundus_capture_state.freezed.dart';

@freezed
class FundusCaptureState with _$FundusCaptureState {
  const factory FundusCaptureState.loading() = _Loading;
  const factory FundusCaptureState.loaded(String data) = _Loaded;
  const factory FundusCaptureState.error(String message) = _Error;
}
