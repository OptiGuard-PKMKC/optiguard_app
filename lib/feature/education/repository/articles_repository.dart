import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optiguard/feature/education/state/article_state.dart';
import 'package:optiguard/shared/util/db_loader.dart';

abstract class ArticlesRepositoryProtocol {
  Future<ArticlesState> fetchArticles();
}

final articlesRepositoryProvider = Provider<ArticlesRepository>((ref) {
  return ArticlesRepository(ref);
});

class ArticlesRepository implements ArticlesRepositoryProtocol {
  ArticlesRepository(this._ref);

  final Ref _ref;

  @override
  Future<ArticlesState> fetchArticles() async {
    try {
      final dbHelper = _ref.read(dbLoadProvider);
      final articles = await dbHelper.getArticles();
      return ArticlesState.loaded(articles);
    } catch (e) {
      return ArticlesState.error('Failed to fetch articles: $e');
    }
  }
}
