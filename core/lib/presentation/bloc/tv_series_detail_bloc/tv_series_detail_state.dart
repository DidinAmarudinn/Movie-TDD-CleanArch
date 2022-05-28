// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailState {
  final TvSeriesDetail? tvSeriesDetail;
  final RequestState tvSeriesDetailState;
  final List<TvSeries> tvSeriesRecomendations;
  final RequestState movieRecommendationsState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  TvSeriesDetailState(
      {required this.tvSeriesDetail,
      required this.tvSeriesDetailState,
      required this.tvSeriesRecomendations,
      required this.movieRecommendationsState,
      required this.isAddedToWatchlist,
      required this.message,
      required this.watchlistMessage});

  TvSeriesDetailState copyWith({
    TvSeriesDetail? tvSeriesDetail,
    RequestState? tvSeriesDetailState,
    List<TvSeries>? tvSeriesRecomendations,
    RequestState? movieRecommendationsState,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return TvSeriesDetailState(
      tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
      tvSeriesDetailState: tvSeriesDetailState ?? this.tvSeriesDetailState,
      tvSeriesRecomendations:
          tvSeriesRecomendations ?? this.tvSeriesRecomendations,
      movieRecommendationsState:
          movieRecommendationsState ?? this.movieRecommendationsState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }
  factory TvSeriesDetailState.initial() => TvSeriesDetailState(
      tvSeriesDetail: null,
      tvSeriesDetailState: RequestState.Empty,
      tvSeriesRecomendations: [],
      movieRecommendationsState: RequestState.Empty,
      isAddedToWatchlist: false,
      watchlistMessage: "",
      message: "");
}
