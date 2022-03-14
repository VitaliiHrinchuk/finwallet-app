import 'package:bloc/bloc.dart';

part 'auth_form_state.dart';

class AuthFormCubit extends Cubit<AuthFormState> {
  AuthFormCubit() : super(AuthFormInitial());

  void setEmail(email){

    emit(state.copyWith(email: email));
  }

  void setPassword(password){
    emit(state.copyWith(password: password));
  }

  void setConfirmPassword(password){
    emit(state.copyWith(confirmPassword: password));
  }

}
