import 'package:flutter_boilerplate/feature/auth/provider/auth_provider.dart';
import 'package:flutter_boilerplate/feature/auth/repository/token_repository.dart';
import 'package:flutter_boilerplate/feature/auth/state/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/app_start_state.dart';

part 'app_start_provider.g.dart';

@riverpod
class AppStartNotifier extends _$AppStartNotifier {
  late final TokenRepository _tokenRepository =
      ref.read(tokenRepositoryProvider);

  @override
  FutureOr<AppStartState> build() async {
    ref.onDispose(() {});

    final _authState = ref.watch(authNotifierProvider);

    if (_authState is AuthStateLoggedIn) {
      return AppStartState.authenticated(role: _authState.role);
    }

    if (_authState is AuthStateLoggedOut) {
      return AppStartState.unauthenticated();
    }

    final token = await _tokenRepository.fetchToken();
    if (token != null) {
      final role = await _tokenRepository.fetchUserRole(token.token);
      return AppStartState.authenticated(role: role);
    } else {
      return const AppStartState.unauthenticated();
    }
  }
}
