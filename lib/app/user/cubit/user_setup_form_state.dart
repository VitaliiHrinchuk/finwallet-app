part of 'user_setup_form_cubit.dart';

class UserSetupFormState {
  final String name;
  final Currency? baseCurrency;

  UserSetupFormState({
    required this.name,
    required this.baseCurrency
  });

  UserSetupFormState copyWith({name, baseCurrency}) =>
      UserSetupFormState(
          name: name ?? this.name,
          baseCurrency: baseCurrency);
}

class UserSetupFormInitial extends UserSetupFormState {
  UserSetupFormInitial() : super(baseCurrency: null, name: '');
}
