import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
final GetWatchlistMovies getWatchlistMovies;
  WatchlistMovieBloc({required this.getWatchlistMovies})
      : super(WatchlistMoviesEmpty()) {
    on<WatchlistMovieEvent>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(WatchlistMoviesError(failure.message)),
        (movies) => emit(WatchlistMoviesHasData(movies)),
      );
    });
  }
}
