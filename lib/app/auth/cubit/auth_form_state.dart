part of 'auth_form_cubit.dart';

class AuthFormState {
  final String email;
  final String password;
  final String confirmPassword;

  AuthFormState({
    required this.email,
    required this.password,
    this.confirmPassword = ""
  });
  AuthFormState copyWith({email, password, confirmPassword}) =>
      AuthFormState(
          email: email ?? this.email,
          password: password ?? this.password,
          confirmPassword: confirmPassword ?? this.confirmPassword);
}

class AuthFormInitial extends AuthFormState {
  AuthFormInitial() : super(email: 'a@a.com', password: '123456');
}
