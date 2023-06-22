import 'package:bloc/bloc.dart';
import 'package:doctor_app/screens/login/model/login_response.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<GetUpdatedUserDataEvent>((event, emit) {
      emit(GetUpdatedUserDataState(updatedLoginData: event.updatedLoginData));
    });
  }
}
