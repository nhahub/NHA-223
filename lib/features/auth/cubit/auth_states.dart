import 'package:final_depi_project/features/auth/data/model/signup_response.dart';

import '../data/model/login_response.dart';

abstract class AuthState  {}

class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final LoginResponse loginResponse;
  LoginSuccessState(this.loginResponse);
}

class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState(this.message);
}
class SignupLoadingState extends AuthState {}

class SignupSuccessState extends AuthState {
  final SignupResponse signupResponse;
  SignupSuccessState(this.signupResponse);
}

class SignupErrorState extends AuthState {
  final String message;
  SignupErrorState(this.message);
}
