import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optiguard/feature/education/model/article.dart';

part 'articles_state.freezed.dart';

@freezed
class ArticlesState with _$ArticlesState {
  const factory ArticlesState.loading() = _Loading;
  const factory ArticlesState.loaded(List<Article> data) = _Loaded;
  const factory ArticlesState.error(String message) = _Error;
}

@freezed
class ArticleDetailState with _$ArticleDetailState {
  const factory ArticleDetailState.loading() = _LoadingDetail;
  const factory ArticleDetailState.loaded(Article data) = _LoadedDetail;
  const factory ArticleDetailState.error(String message) = _ErrorDetail;
}
