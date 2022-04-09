part of 'tag_list_cubit.dart';

class TagListState {
  final bool loading;
  final List<TagEntity> entities;
  final String? error;
  final bool loaded;


  TagListState({
    required this.entities,
    required this.loading,
    this.loaded = false,
    this.error
  });

  TagListState copyWith({entities, loading, error, loaded}) =>
      TagListState(
          entities: entities ?? this.entities,
          loading: loading ?? this.loading,
          error: error ?? this.error,
          loaded: loaded ?? this.loaded
      );
}

class TagListInitial extends TagListState {
  TagListInitial() : super(
    loading: false,
    entities: [],
  );
}
