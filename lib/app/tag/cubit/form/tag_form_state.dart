part of 'tag_form_cubit.dart';

class TagFormState {
  final String? name;
  final bool loading;
  final String? error;
  final bool saved;

  TagFormState({
    this.name,
    this.loading = false,
    this.error,
    this.saved = false
  });

  TagFormState copyWith({name, loading, error, saved}) =>
      TagFormState(
          name: name ?? this.name,
          loading: loading ?? this.loading,
          error: error ?? this.error,
          saved: saved ?? this.saved
      );
}

class TagFormInitial extends TagFormState {
  TagFormInitial() : super();
}