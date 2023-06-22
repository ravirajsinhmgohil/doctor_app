part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginWithGoogleBusyState extends LoginState {}

class LoginWithGoogleSuccessState extends LoginState {
  final LoginResponse loginResponse;

  LoginWithGoogleSuccessState({required this.loginResponse});
}

class LoginWithGoogleFailureState extends LoginState {
  final String error;

  LoginWithGoogleFailureState({required this.error});
}

class ChangePasswordVisibilityState extends LoginState {
  final bool isVisible;

  ChangePasswordVisibilityState({required this.isVisible});
}
