import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecases/get_popular_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class PopularMovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetPopularMovies getPopularMovies;
  PopularMovieListBloc(
      {required this.getPopularMovies})
      : super(MovieListEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(MoviePopularLoading());
      final result = await getPopularMovies.execute();
      result.fold((failure) {
        emit(MoviePopularError(failure.message));
      }, (movies) {
        emit(MoviePopularHasData(movies));
      });
    });
  }
}


class TopRatedMovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMovieListBloc(
      {required this.getTopRatedMovies})
      : super(MovieListEmpty()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(MovieTopRatedLoading());
      final result = await getTopRatedMovies.execute();
      result.fold((failure) {
        emit(MovieTopRatedError(failure.message));
      }, (movies) {
        emit(MovieTopRatedHasData(movies));
      });
    });
  }
}
class NowPlayingMovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMovieListBloc(
      {required this.getNowPlayingMovies})
      : super(MovieListEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(MovieNowPlayingLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(MovieNowPlayingError(failure.message));
      }, (movies) {
        emit(MovieNowPlayingHasData(movies));
      });
    });
  }
}
