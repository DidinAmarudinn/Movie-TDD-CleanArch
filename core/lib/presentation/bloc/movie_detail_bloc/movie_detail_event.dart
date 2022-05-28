part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailMovie extends MovieDetailEvent {
  final int id;

  const FetchDetailMovie(this.id);
  @override
  List<Object> get props => [id];
}

class LoadWatchlistStatus extends MovieDetailEvent {
  final int id;

  const LoadWatchlistStatus(this.id);
  @override
  List<Object> get props => [];
}

class RemoveFromWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchlist(this.movieDetail);
  @override
  List<Object> get props => [movieDetail];
}

class AddToWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const AddToWatchlist(this.movieDetail);
  @override
  List<Object> get props => [movieDetail];
}

