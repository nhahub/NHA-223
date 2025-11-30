import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/shared_prefrences.dart';
import '../data/repo/auth_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());

    try {
      final loginResponse = await authRepository.login(
        email: email,
        password: password,
      );
      AppSharedPreferences.setString(SharedPreferencesKeys.name, loginResponse.user.name);
      await saveToken(loginResponse.token);

      emit(LoginSuccessState(loginResponse));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String rePassword,
  }) async {
    emit(SignupLoadingState());
    try {
      final response = await authRepository.signup(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
      );
      AppSharedPreferences.setString(SharedPreferencesKeys.name, response.user.name);
      name=response.user.name;
      emit(SignupSuccessState(response));
      saveToken(response.token);
    }  catch (e) {
      print("this is the error ${e.toString()}");
      emit(SignupErrorState(e.toString()));
    }
  }

  Future<void> saveToken(String token) async {
    await AppSharedPreferences.setString(
      SharedPreferencesKeys.token,
      token,
    );
  }

}
