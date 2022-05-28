part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListEmpty extends MovieListState {}

class MovieTopRatedLoading extends MovieListState {}

class MovieNowPlayingLoading extends MovieListState {}

class MoviePopularLoading extends MovieListState {}

class MovieNowPlayingError extends MovieListState {
  final String message;

  const MovieNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviePopularError extends MovieListState {
  final String message;

  const MoviePopularError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieTopRatedError extends MovieListState {
  final String message;

  const MovieTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieTopRatedHasData extends MovieListState {
  final List<Movie> movies;

  const MovieTopRatedHasData(this.movies);
  @override
  List<Object> get props => [movies];
}

class MovieNowPlayingHasData extends MovieListState {
  final List<Movie> movies;

  const MovieNowPlayingHasData(this.movies);
  @override
  List<Object> get props => [movies];
}

class MoviePopularHasData extends MovieListState {
  final List<Movie> movies;

  const MoviePopularHasData(this.movies);
  @override
  List<Object> get props => [movies];
}
