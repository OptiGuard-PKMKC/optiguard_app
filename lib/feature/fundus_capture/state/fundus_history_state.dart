import 'package:freezed_annotation/freezed_annotation.dart';

part 'fundus_history_state.freezed.dart';

@freezed
class FundusHistoryState with _$FundusHistoryState {
  const factory FundusHistoryState.loading() = _Loading;
  const factory FundusHistoryState.loaded(List<Map<String, dynamic>> data) = _Loaded;
  const factory FundusHistoryState.error(String message) = _Error;
}