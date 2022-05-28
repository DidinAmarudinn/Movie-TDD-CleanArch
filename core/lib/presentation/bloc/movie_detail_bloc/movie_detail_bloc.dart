import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';
import '../../../utils/state_enum.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  MovieDetailBloc(
      {required this.getMovieDetail,
      required this.getMovieRecommendations,
      required this.getWatchListStatus,
      required this.saveWatchlist,
      required this.removeWatchlist})
      : super(MovieDetailState.initial()) {
    on<FetchDetailMovie>((event, emit) async {
      emit(state.copyWith(movieDetailState: RequestState.Loading));
      final result = await getMovieDetail.execute(event.id);
      final movieRecomendations =
          await getMovieRecommendations.execute(event.id);
      result.fold((failure) {
        emit(
          state.copyWith(
              movieDetailState: RequestState.Error, message: failure.message),
        );
      }, (movieDetail) async {
        emit(state.copyWith(
          movieRecommendationsState: RequestState.Loading,
          movieDetail: movieDetail,
          movieDetailState: RequestState.Loaded,
        ));
        movieRecomendations.fold((failure) {
          emit(state.copyWith(
            movieRecommendationsState: RequestState.Error,
            message: failure.message,
          ));
        }, (moviesRecomendation) {
          emit(state.copyWith(
            movieRecommendations: moviesRecomendation,
            movieRecommendationsState: RequestState.Loaded,
          ));
        });
      });
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);
      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (success) {
        emit(state.copyWith(watchlistMessage: success));
      });
      add(LoadWatchlistStatus(event.movieDetail.id));
    });
    on<AddToWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);
      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (success) {
        emit(state.copyWith(watchlistMessage: success));
      });
      add(LoadWatchlistStatus(event.movieDetail.id));
    });
  }
}
