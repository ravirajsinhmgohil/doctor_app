import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/screens/login/data/login_repository.dart';
import 'package:doctor_app/screens/login/model/login_request.dart';
import 'package:doctor_app/screens/login/model/login_response.dart';
import 'package:doctor_app/utils/shared_prefs_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;
  LoginBloc({required this.repository}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<ChangePasswordVisibility>(_changePasswordVisibility);
    on<LoginWithGoogleEvent>(_loginWithGoogle);
  }
  _loginWithGoogle(LoginWithGoogleEvent event, Emitter<LoginState> emit) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        emit(LoginWithGoogleBusyState());
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential authCredential = AuthCredential(
            providerId: GoogleAuthProvider.PROVIDER_ID,
            signInMethod: GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD,
            accessToken: googleSignInAuthentication.accessToken);

        await firebaseAuth.signInWithCredential(authCredential);

        User? user = firebaseAuth.currentUser;
        LoginRequest loginRquest =
            LoginRequest(email: user?.email, name: user?.displayName ?? '');
        dynamic data = await repository.doLogin(loginRequest: loginRquest);
        LoginResponse loginRepsonse = LoginResponse.fromJson(data);
        if (loginRepsonse.success == true) {
          String loginStringData = jsonEncode(loginRepsonse);
          await SharedPrefs.setLoginData(loginData: loginStringData);
          await SharedPrefs.setToken(userToken: loginRepsonse.token ?? '');
          emit(LoginWithGoogleSuccessState(loginResponse: loginRepsonse));
        }
      }
    } catch (e) {
      emit(LoginWithGoogleFailureState(error: e.toString()));
    }
  }

  _changePasswordVisibility(
      ChangePasswordVisibility event, Emitter<LoginState> emit) {
    emit(ChangePasswordVisibilityState(isVisible: !event.isVisible));
  }
}
