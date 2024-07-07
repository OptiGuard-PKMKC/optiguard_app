import 'package:optiguard/feature/education/repository/articles_repository.dart';
import 'package:optiguard/feature/education/state/article_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'articles_provider.g.dart';

@riverpod
class ArticleNotifier extends _$ArticleNotifier {
  late final ArticlesRepository _repository =
      ref.read(articlesRepositoryProvider);

  @override
  ArticlesState build() {
    _fetchArticles();
    return const ArticlesState.loading();
  }

  void _fetchArticles() {
    _repository.fetchArticles().then((response) {
      state = response;
    });
  }
}
