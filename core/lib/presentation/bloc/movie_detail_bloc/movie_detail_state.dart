// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable{
  final MovieDetail? movieDetail;
  final RequestState movieDetailState;
  final List<Movie> movieRecommendations;
  final RequestState movieRecommendationsState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  MovieDetailState(
      {required this.movieDetail,
      required this.movieDetailState,
      required this.movieRecommendations,
      required this.movieRecommendationsState,
      required this.isAddedToWatchlist,
      required this.message,
      required this.watchlistMessage});

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    RequestState? movieDetailState,
    List<Movie>? movieRecommendations,
    RequestState? movieRecommendationsState,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieRecommendationsState:
          movieRecommendationsState ?? this.movieRecommendationsState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  factory MovieDetailState.initial() => MovieDetailState(
      movieDetail: null,
      movieDetailState: RequestState.Empty,
      movieRecommendations: [],
      movieRecommendationsState: RequestState.Empty,
      isAddedToWatchlist: false,
      watchlistMessage: "",
      message: "");

  @override
  List<Object?> get props => [movieDetail,movieDetailState,movieRecommendations,movieRecommendationsState,message,watchlistMessage];
}
