part of 'base_bloc.dart';

@immutable
abstract class BaseEvent {}

class ChangeBottomNavigationEvent extends BaseEvent {
  final int selectedIndex;

  ChangeBottomNavigationEvent({required this.selectedIndex});
}

class UpdateMobileNumberEvent extends BaseEvent {
  final UpdateNumberRequest updateNumberRequest;

  UpdateMobileNumberEvent({required this.updateNumberRequest});
}
