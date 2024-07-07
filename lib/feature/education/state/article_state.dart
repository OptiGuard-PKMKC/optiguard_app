import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optiguard/feature/education/model/article.dart';

part 'article_state.freezed.dart';

@freezed
class ArticlesState with _$ArticlesState {
  const factory ArticlesState.loading() = _Loading;
  const factory ArticlesState.loaded(List<Article> data) = _Loaded;
  const factory ArticlesState.error(String message) = _Error;
}