part of 'base_bloc.dart';

@immutable
abstract class BaseState {}

class BaseInitial extends BaseState {}

class ChangeBottomNavigationState extends BaseState {
  final int selectedIndex;

  ChangeBottomNavigationState({required this.selectedIndex});
}

class UpdateMobileNumberBusyState extends BaseState {}

class UpdateMobileNumberSuccessState extends BaseState {
  final LoginResponse updateNumberResponse;

  UpdateMobileNumberSuccessState({required this.updateNumberResponse});
}

class UpdateMobileNumberFailureState extends BaseState {
  final String error;

  UpdateMobileNumberFailureState({required this.error});
}
