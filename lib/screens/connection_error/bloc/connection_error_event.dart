part of 'connection_error_bloc.dart';

@immutable
abstract class ConnectionErrorEvent {}

class GetConnectionStatus extends ConnectionErrorEvent {}

class CheckConnectionStatus extends ConnectionErrorEvent {
  final ConnectivityResult connectivityResult;

  CheckConnectionStatus({required this.connectivityResult});
}
