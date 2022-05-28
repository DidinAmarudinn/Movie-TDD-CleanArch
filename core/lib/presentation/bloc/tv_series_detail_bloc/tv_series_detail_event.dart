part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}
class FetchDetailTvSeries extends TvSeriesDetailEvent {
  final int id;

  const FetchDetailTvSeries(this.id);
  @override
  List<Object> get props => [id];
}

class LoadWatchlistStatus extends TvSeriesDetailEvent {
  final int id;

  const LoadWatchlistStatus(this.id);
  @override
  List<Object> get props => [];
}

class RemoveFromWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveFromWatchlist(this.tvSeriesDetail);
  @override
  List<Object> get props => [TvSeriesDetail];
}

class AddToWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  const AddToWatchlist(this.tvSeriesDetail);
  @override
  List<Object> get props => [TvSeriesDetail];
}
