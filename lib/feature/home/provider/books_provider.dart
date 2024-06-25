import 'package:optiguard/app/provider/app_start_provider.dart';
import 'package:optiguard/feature/home/repository/books_repository.dart';
import 'package:optiguard/feature/home/state/books_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'books_provider.g.dart';

//Generated by @riverpod
// final booksNotifierProvider = NotifierProvider<BooksNotifier, BooksState>(() {
//   return BooksNotifier();
// });

@riverpod
class BooksNotifier extends _$BooksNotifier {
  late final BooksRepository _repository = ref.read(booksRepositoryProvider);

  @override
  BooksState build() {
    // ref.watch(appStartNotifierProvider).when(
    //     data: (data) {
    //       data.maybeWhen(
    //           authenticated: () {
    //             _fetchBooks();
    //           },
    //           orElse: () {});
    //     },
    //     error: (e, st) {},
    //     loading: () {});

    ref.listen(appStartNotifierProvider, (previous, next) {
      next.when(
          data: (data) {
            data.maybeWhen(
                authenticated: (_) {
                  _fetchBooks();
                },
                orElse: () {});
          },
          error: (e, st) {},
          loading: () {});
    });

    return const BooksState.loading();
  }

  //late final AppStartState _appStartState = ref.watch(appStartNotifierProvider);

  // Future<void> _init() async {
  //   _appStartState.maybeWhen(
  //       authenticated: () {
  //         _fetchBooks();
  //       },
  //       orElse: () {});
  // }

  Future<void> _fetchBooks() async {
    final response = await _repository.fetchBooks();
    state = response;
  }
}
