part of 'popular_tv_series_bloc.dart';

abstract class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();
  
  @override
  List<Object> get props => [];
}
class PopularTvSeriesEmpty extends PopularTvSeriesState {}

class PopularTvSeriesLoading extends PopularTvSeriesState {}

class PopularTvSeriesError extends PopularTvSeriesState {
  final String message;

  const PopularTvSeriesError(this.message);
  @override
  List<Object> get props => [message];
}

class PopularTvSeriesHasData extends PopularTvSeriesState {
  final List<TvSeries> tvSeries;

  const PopularTvSeriesHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}
