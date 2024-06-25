import 'package:optiguard/feature/fundus_capture/state/fundus_capture_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fundus_capture_provider.g.dart';

@riverpod
class FundusCaptureNotifier extends _$FundusCaptureNotifier {
  @override
  FundusCaptureState build() {
    return const FundusCaptureState.loaded('Camera loaded');
  }

  Future<void> loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      const data = 'Data loaded';
      state = const FundusCaptureState.loaded(data);
    } catch (e) {
      state = const FundusCaptureState.error('Failed to load data');
    }
  }
}
