part of 'analytics_cubit.dart';


class AnalyticsState<T> {
  final bool loading;
  final List<T> models;
  final String? error;
  final bool loaded;
  final AnalyticsFilters filters;

  AnalyticsState({
    required this.models,
    required this.loading,
    this.loaded = false,
    required this.filters,
    this.error
  });

  AnalyticsState<T> copyWith({models, loading, error, loaded, filters}) =>
      AnalyticsState<T>(
          models: models ?? this.models,
          loading: loading ?? this.loading,
          error: error ?? this.error,
          loaded: loaded ?? this.loaded,
          filters: filters ?? this.filters
      );
}

class AnalyticsInitial<T> extends AnalyticsState<T> {
  AnalyticsInitial() : super(
    loading: false,
    models: [],
    filters: AnalyticsFilters()
  );
}
