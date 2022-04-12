part of 'analytics_cubit.dart';


class AnalyticsState<T> {
  final bool loading;
  final List<T> models;
  final String? error;
  final bool loaded;

  AnalyticsState({
    required this.models,
    required this.loading,
    this.loaded = false,
    this.error
  });

  AnalyticsState<T> copyWith({models, loading, error, loaded}) =>
      AnalyticsState<T>(
          models: models ?? this.models,
          loading: loading ?? this.loading,
          error: error ?? this.error,
          loaded: loaded ?? this.loaded
      );
}

class AnalyticsInitial<T> extends AnalyticsState<T> {
  AnalyticsInitial() : super(
    loading: false,
    models: [],
  );
}
