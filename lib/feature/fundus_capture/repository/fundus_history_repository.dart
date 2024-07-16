import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optiguard/feature/fundus_capture/state/fundus_history_state.dart';
import 'package:optiguard/shared/util/db_loader.dart';

abstract class FundusHistoryRepositoryProtocol {
  Future<FundusHistoryState> fetchFundusImages();
  Future<FundusHistoryState> deleteFundusImage(int id);
}

final fundusHistoryRepositoryProvider = Provider<FundusHistoryRepository>((ref) {
  return FundusHistoryRepository(ref);
});

class FundusHistoryRepository implements FundusHistoryRepositoryProtocol {
  FundusHistoryRepository(this._ref);

  final Ref _ref;

  @override
  Future<FundusHistoryState> fetchFundusImages() async {
    try {
      final dbHelper = _ref.read(dbLoadProvider);
      final images = await dbHelper.getImages();
      return FundusHistoryState.loaded(images);
    } catch (e) {
      return FundusHistoryState.error('Failed to fetch images: $e');
    }
  }

  @override
  Future<FundusHistoryState> deleteFundusImage(int id) async {
    try {
      final dbHelper = _ref.read(dbLoadProvider);
      await dbHelper.deleteImage(id);
      final images = await dbHelper.getImages();
      return FundusHistoryState.loaded(images);
    } catch (e) {
      return FundusHistoryState.error('Failed to delete image: $e');
    }
  }
}