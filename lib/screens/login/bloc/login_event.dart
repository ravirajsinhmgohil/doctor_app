part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginWithGoogleEvent extends LoginEvent {}

class ChangePasswordVisibility extends LoginEvent {
  final bool isVisible;

  ChangePasswordVisibility({required this.isVisible});
}
