part of 'category_form_cubit.dart';

class CategoryFormState {
  final String? name;
  final CategoryType? type;
  final bool loading;
  final String? error;
  final bool saved;

  CategoryFormState({
    this.name,
    this.type,
    this.loading = false,
    this.error,
    this.saved = false
  });

  CategoryFormState copyWith({name, type, loading, error, saved}) =>
      CategoryFormState(
          name: name ?? this.name,
          type: type ?? this.type,
          loading: loading ?? this.loading,
          error: error ?? this.error,
          saved: saved ?? this.saved
      );
}

class CategoryFormInitial extends CategoryFormState {
  CategoryFormInitial() : super();
}