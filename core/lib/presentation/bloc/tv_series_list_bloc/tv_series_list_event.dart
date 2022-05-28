part of 'tv_series_list_bloc.dart';

class TvSeriesListEvent extends Equatable {
  const TvSeriesListEvent();

  @override
  List<Object> get props => [];
}
class FetchTopRatedTvSeries extends TvSeriesListEvent{}

class FetchOnAirTvSeries extends TvSeriesListEvent{}

class FetchPopularTvSeries extends TvSeriesListEvent{}