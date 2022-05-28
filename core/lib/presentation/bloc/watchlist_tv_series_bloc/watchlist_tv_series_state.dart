part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();
  
  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesEmpty extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {}

class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesError(this.message);
  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesHasData extends WatchlistTvSeriesState {
  final List<TvSeries> tvSeries;

  const WatchlistTvSeriesHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}
