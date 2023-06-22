part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}
class GetUpdatedUserDataEvent extends ProfileEvent {
  final LoginResponse updatedLoginData;

  GetUpdatedUserDataEvent({required this.updatedLoginData});
}