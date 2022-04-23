part of 'category_list_cubit.dart';


class CategoryListState {
  final bool loading;
  final List<CategoryEntity> entities;
  final String? error;
  final bool loaded;

  List<CategoryEntity> get creditEntities =>
      this.entities.where((element) => element.type == CategoryType.CRE).toList();

  List<CategoryEntity> get debitEntities =>
      this.entities.where((element) => element.type == CategoryType.DEB).toList();

  List<CategoryEntity> get customCategories =>
      this.entities.where((element) => element.createdBy != null).toList();

  CategoryListState({
    required this.entities,
    required this.loading,
    this.loaded = false,
    this.error
  });

  CategoryListState copyWith({entities, loading, error, loaded}) =>
      CategoryListState(
          entities: entities ?? this.entities,
          loading: loading ?? this.loading,
          error: error ?? this.error,
          loaded: loaded ?? this.loaded
      );
}

class CategoryListInitial extends CategoryListState {
  CategoryListInitial() : super(
    loading: false,
    entities: [],
  );
}
