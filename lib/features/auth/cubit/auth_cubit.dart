import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/shared_prefrences.dart';
import '../data/repo/auth_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    try {
      final loginResponse = await authRepository.login(
        email: email,
        password: password,
      );
      print("object token is :${loginResponse.token}");
      await saveToken(loginResponse.token);

      emit(LoginSuccessState(loginResponse));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> saveToken(String token) async {
    await AppSharedPreferences.setString(
      SharedPreferencesKeys.token,
      token,
    );
  }

  // TODO: still have work to do with it
  Future<void> logout() async {
    await AppSharedPreferences.remove(SharedPreferencesKeys.token);
    emit(AuthInitial());
  }
}
