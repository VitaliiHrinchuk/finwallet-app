import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/user/domain/user_entity.dart';
import 'package:finwallet_app/app/user/usecases/fetch_user.dart';
import 'package:finwallet_app/app/user/usecases/setup_user.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/error/exceptions.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchUser fetchUser;
  final SetupUser setupUser;

  UserBloc(this.fetchUser, this.setupUser) : super(UserInitial()) {
    on<UserFetch>(_onUserFetch);
    on<UserSetup>(_onUserSetup);
  }

  void _onUserFetch(UserFetch event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      UserEntity user = await this.fetchUser(EmptyParams());

      if (user.userConfigured) {
        emit(UserLoaded(user));
      } else {
        emit(UserNotConfigured());
      }

    } on ValidationException catch (error) {
      emit(UserValidationError(errors: error.messages));
    } on HttpException catch (error) {
      print(error);
      emit(UserError(error: error.message));
    } catch (error) {
      print(error);
      emit(UserError(error: error.toString()));
    }
  }

  void _onUserSetup(UserSetup event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      UserEntity user = await this
          .setupUser(SetupUserParams(baseCurrency: event.baseCurrency));
      emit(UserIsSetup());
      emit(UserLoaded(user));
    } on ValidationException catch (error) {
      emit(UserValidationError(errors: error.messages));
    } on HttpException catch (error) {
      emit(UserError(error: error.message));
    } catch (error) {
      emit(UserError(error: error.toString()));
    }
  }
}
