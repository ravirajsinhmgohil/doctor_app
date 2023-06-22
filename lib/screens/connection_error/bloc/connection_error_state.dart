part of 'connection_error_bloc.dart';

@immutable
abstract class ConnectionErrorState {}

class ConnectionErrorInitial extends ConnectionErrorState {}

class CheckConnectionFailureState extends ConnectionErrorState {}

class CheckConnectionSuccessState extends ConnectionErrorState {}
