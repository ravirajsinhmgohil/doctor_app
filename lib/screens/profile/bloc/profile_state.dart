part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class GetUpdatedUserDataState extends ProfileState {
  final LoginResponse updatedLoginData;

  GetUpdatedUserDataState({required this.updatedLoginData});
}