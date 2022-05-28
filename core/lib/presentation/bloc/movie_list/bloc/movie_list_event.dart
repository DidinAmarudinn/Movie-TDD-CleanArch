part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedMovies extends MovieListEvent{}

class FetchNowPlayingMovies extends MovieListEvent{}

class FetchPopularMovies extends MovieListEvent{}