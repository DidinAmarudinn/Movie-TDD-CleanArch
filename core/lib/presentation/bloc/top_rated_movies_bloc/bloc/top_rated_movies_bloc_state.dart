part of 'top_rated_movies_bloc_bloc.dart';

abstract class TopRatedMoviesBlocState extends Equatable {
  const TopRatedMoviesBlocState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesEmpty extends TopRatedMoviesBlocState {}

class TopRatedMoviesLoading extends TopRatedMoviesBlocState {}

class TopRateMoviesError extends TopRatedMoviesBlocState {
  final String message;

  const TopRateMoviesError(this.message);
  @override
  List<Object> get props => [message];
}

class TopRateMoviesHasData extends TopRatedMoviesBlocState {
  final List<Movie> movies;

  const TopRateMoviesHasData(this.movies);

  @override
  List<Object> get props => [movies];
}
