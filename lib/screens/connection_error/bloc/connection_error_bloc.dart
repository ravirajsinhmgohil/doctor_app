import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'connection_error_event.dart';
part 'connection_error_state.dart';

class ConnectionErrorBloc
    extends Bloc<ConnectionErrorEvent, ConnectionErrorState> {
  bool isFirstTime = true;
  ConnectionErrorBloc() : super(ConnectionErrorInitial()) {
    on<ConnectionErrorEvent>((event, emit) {});
    on<GetConnectionStatus>(_getConnection);
    on<CheckConnectionStatus>(_checkConnection);
  }
  _getConnection(
      GetConnectionStatus event, Emitter<ConnectionErrorState> emit) {
    Connectivity().onConnectivityChanged.listen((connectivityResult) {
      add(CheckConnectionStatus(connectivityResult: connectivityResult));
    });
  }

  _checkConnection(
      CheckConnectionStatus event, Emitter<ConnectionErrorState> emit) {
    if (event.connectivityResult == ConnectivityResult.none) {
      emit(CheckConnectionFailureState());
    } else {
      if (isFirstTime == false) {
        emit(CheckConnectionSuccessState());
      } else {
        isFirstTime = false;
      }
    }
  }
}
