part of 'tv_series_list_bloc.dart';

abstract class TvSeriesListState extends Equatable {
  const TvSeriesListState();
  
  @override
  List<Object> get props => [];
}

class TvSeriesListEmpty extends TvSeriesListState {}

class TvSeriesTopRatedLoading extends TvSeriesListState {}

class TvSeriesOnAirLoading extends TvSeriesListState {}

class TvSeriesPopularLoading extends TvSeriesListState {}

class TvSeriesOnAirError extends TvSeriesListState {
  final String message;

  const TvSeriesOnAirError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesPopularError extends TvSeriesListState {
  final String message;

  const TvSeriesPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesTopRatedError extends TvSeriesListState {
  final String message;

  const TvSeriesTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesTopRatedHasData extends TvSeriesListState {
  final List<TvSeries> tvSeries;

  const TvSeriesTopRatedHasData(this.tvSeries);
  @override
  List<Object> get props => [tvSeries];
}

class TvSeriesOnAirHasData extends TvSeriesListState {
  final List<TvSeries> tvSeries;

  const TvSeriesOnAirHasData(this.tvSeries);
  @override
  List<Object> get props => [tvSeries];
}

class TvSeriesPopularHasData extends TvSeriesListState {
  final List<TvSeries> tvSeries;

  const TvSeriesPopularHasData(this.tvSeries);
  @override
  List<Object> get props => [tvSeries];
}
