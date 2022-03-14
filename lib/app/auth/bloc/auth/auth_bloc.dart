import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/auth/domain/auth_repository_contract.dart';
import 'package:finwallet_app/app/auth/domain/auth_user_entity.dart';
import 'package:finwallet_app/app/auth/domain/credentials.dart';
import 'package:finwallet_app/app/auth/usecases/check_user.dart';
import 'package:finwallet_app/app/auth/usecases/signin_user.dart';
import 'package:finwallet_app/app/auth/usecases/signout_user.dart';
import 'package:finwallet_app/app/auth/usecases/signup_user.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/error/exceptions.dart';
import 'package:finwallet_app/common/http_client/exceptions.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUser _signinUser;
  final SignoutUser _signoutUser;
  final CheckUser _checkUser;
  final SignupUser _signUpUser;

  AuthBloc(
    this._signinUser,
    this._signoutUser,
    this._checkUser,
    this._signUpUser
  ) : super(AuthInitial()) {
    on<AuthChecked>(_onAuthChecked);
    on<AuthAttempt>(_onAuthAttempt);
    on<AuthLogout>(_onAuthLogout);
    on<AuthErrorEvent>(_onAuthError);
    on<AuthAttemptSignup>(_onAuthAttemptSignup);
  }

  void _onAuthChecked(AuthChecked event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      bool authorized = await this._checkUser(EmptyParams());

      if (!authorized) {
        emit(AuthInitial());
      } else {
        emit(AuthAuthenticated());
      }
    } catch (error) {
      emit(AuthError(error: error.toString()));
    }
  }

  void _onAuthAttempt(AuthAttempt event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await this._signinUser(SigninUserParams(
        email: event.email,
        password: event.password
      ));

      emit(AuthAuthenticated());
    } on ValidationException catch (error) {
      emit(AuthValidationError(errors: error.messages));
    } on HttpException catch (error) {
      emit(AuthError(error: error.message));
    }
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await this._signoutUser(EmptyParams());
    emit(AuthInitial());
  }

  void _onAuthError(AuthErrorEvent event, Emitter<AuthState> emit) {
    emit(AuthError());
  }

  void _onAuthAttemptSignup(AuthAttemptSignup event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await this._signUpUser(SignupUserParams(
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword
      ));

      emit(AuthAuthenticated());
    } on ValidationException catch (error) {
      emit(AuthValidationError(errors: error.messages));
    } on HttpException catch (error) {
      emit(AuthError(error: error.message));
    }
  }

}
