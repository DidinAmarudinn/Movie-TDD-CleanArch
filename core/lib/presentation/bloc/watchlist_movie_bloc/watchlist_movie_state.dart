part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();
  
  @override
  List<Object> get props => [];
}

class WatchlistMoviesEmpty extends WatchlistMovieState {}

class WatchlistMoviesLoading extends WatchlistMovieState {}

class WatchlistMoviesError extends WatchlistMovieState {
  final String message;

  const WatchlistMoviesError(this.message);
  @override
  List<Object> get props => [message];
}

class WatchlistMoviesHasData extends WatchlistMovieState {
  final List<Movie> movies;

  const WatchlistMoviesHasData(this.movies);

  @override
  List<Object> get props => [movies];
}
