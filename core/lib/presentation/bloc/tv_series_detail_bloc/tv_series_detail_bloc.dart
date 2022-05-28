import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_tv_series_detail.dart';
import '../../../domain/usecases/get_tv_series_recomendation.dart';
import '../../../domain/usecases/remove_watchlist_tv_series.dart';
import '../../../domain/usecases/save_watchlist_tv_series.dart';
import '../../../utils/state_enum.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecomendations getTvSeriesRecomendations;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;
  final GetWatchlistStatusTvSeries getWatchlistStatusTvSeries;
  TvSeriesDetailBloc(
      {required this.getTvSeriesDetail,
      required this.getTvSeriesRecomendations,
      required this.saveWatchlistTvSeries,
      required this.removeWatchlistTvSeries,
      required this.getWatchlistStatusTvSeries})
      : super(TvSeriesDetailState.initial()) {
    on<FetchDetailTvSeries>((event, emit) async {
      emit(state.copyWith(tvSeriesDetailState: RequestState.Loading));
      final result = await getTvSeriesDetail.execute(event.id);
      final tvSeriesRecomendations =
          await getTvSeriesRecomendations.execute(event.id);
      result.fold((failure) {
        emit(
          state.copyWith(
              tvSeriesDetailState: RequestState.Error,
              message: failure.message),
        );
      }, (tvSeriesDetail) async {
        emit(state.copyWith(
          movieRecommendationsState: RequestState.Loading,
          tvSeriesDetail: tvSeriesDetail,
          tvSeriesDetailState: RequestState.Loaded,
        ));
        tvSeriesRecomendations.fold((failure) {
          emit(state.copyWith(
            movieRecommendationsState: RequestState.Error,
            message: failure.message,
          ));
        }, (tvSeriesRecomendations) {
          emit(state.copyWith(
            tvSeriesRecomendations: tvSeriesRecomendations,
            movieRecommendationsState: RequestState.Loaded,
          ));
        });
      });
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchlistStatusTvSeries.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
    on<RemoveFromWatchlist>((event, emit) async {
      final result =
          await removeWatchlistTvSeries.execute(event.tvSeriesDetail);
      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (success) {
        emit(state.copyWith(watchlistMessage: success));
      });
      add(LoadWatchlistStatus(event.tvSeriesDetail.id));
    });
    on<AddToWatchlist>((event, emit) async {
      final result = await saveWatchlistTvSeries.execute(event.tvSeriesDetail);
      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (success) {
        emit(state.copyWith(watchlistMessage: success));
      });
      add(LoadWatchlistStatus(event.tvSeriesDetail.id));
    });
  }
}
