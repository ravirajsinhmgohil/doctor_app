import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/screens/base/data/base_repository.dart';
import 'package:doctor_app/screens/base/models/update_number_request.dart';
import 'package:doctor_app/screens/login/model/login_response.dart';
import 'package:doctor_app/utils/shared_prefs_helper.dart';
import 'package:meta/meta.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  final BaseRepository repository;
  BaseBloc({required this.repository}) : super(BaseInitial()) {
    on<BaseEvent>((event, emit) {});
    on<ChangeBottomNavigationEvent>(_changeBottomNavigation);
    on<UpdateMobileNumberEvent>(_updateNumber);
  }
  _changeBottomNavigation(
      ChangeBottomNavigationEvent event, Emitter<BaseState> emit) {
    emit(ChangeBottomNavigationState(selectedIndex: event.selectedIndex));
  }

  _updateNumber(UpdateMobileNumberEvent event, Emitter<BaseState> emit) async {
    emit(UpdateMobileNumberBusyState());
    dynamic data = await repository.updateNumber(
        updateNumberRequest: event.updateNumberRequest);
    // print(data);
    LoginResponse updateNumberResponse = LoginResponse.fromJson(data);
    // print(updateNumberResponse.success);

    if (updateNumberResponse.success == true) {
      SharedPrefs.updateLoginData(loginData: jsonEncode(updateNumberResponse));
      emit(UpdateMobileNumberSuccessState(
          updateNumberResponse: updateNumberResponse));
    } else {
      emit(UpdateMobileNumberFailureState(error: data.toString()));
    }
  }
}
