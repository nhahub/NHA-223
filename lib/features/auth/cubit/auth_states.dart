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
