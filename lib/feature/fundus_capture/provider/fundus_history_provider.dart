import 'package:optiguard/feature/fundus_capture/repository/fundus_history_repository.dart';
import 'package:optiguard/feature/fundus_capture/state/fundus_history_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fundus_history_provider.g.dart';

@riverpod
class FundusHistoryNotifier extends _$FundusHistoryNotifier {
  late final FundusHistoryRepository _repository = ref.read(fundusHistoryRepositoryProvider);

  @override
  FundusHistoryState build() {
    _fetchImages();
    return const FundusHistoryState.loading();
  }

  void _fetchImages() {
    _repository.fetchFundusImages().then((response) {
      state = response;
    });
  }

  void deleteImage(int id) {
    _repository.deleteFundusImage(id).then((response) {
      state = response;
    });
  }
}