import 'package:optiguard/app/widget/main_page.dart';
import 'package:optiguard/feature/auth/repository/auth_repository.dart';
import 'package:optiguard/feature/auth/repository/token_repository.dart';
import 'package:optiguard/feature/auth/state/auth_state.dart';
import 'package:optiguard/shared/http/app_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

//Generated by @riverpod
// final authNotifierProvider =
//     NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return const AuthState.initial();
  }

  late final AuthRepository _loginRepository = ref.read(authRepositoryProvider);

  Future<void> login(String email, String password) async {
    state = AuthState.loading();

    try {
      state = await _loginRepository.login(email, password);
    } catch (e) {
      state = AuthState.error(AppException.errorWithMessage(e.toString()));
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    state = await _loginRepository.signUp(name, email, password);
  }

  late final TokenRepository _tokenRepository =
      ref.read(tokenRepositoryProvider);

  Future<void> logout() async {
    ref.read(bottomNavNotifier).resetNavigation();
    await _tokenRepository.remove();
    state = const AuthState.loggedOut();
  }
}
