import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/movie_list/bloc/movie_list_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late TopRatedMovieListBloc topRatedMovieListBloc;
  late NowPlayingMovieListBloc nowPlayingMovieListBloc;
  late PopularMovieListBloc popularMovieListBloc;

  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    topRatedMovieListBloc =
        TopRatedMovieListBloc(getTopRatedMovies: mockGetTopRatedMovies);
    popularMovieListBloc =
        PopularMovieListBloc(getPopularMovies: mockGetPopularMovies);
    nowPlayingMovieListBloc =
        NowPlayingMovieListBloc(getNowPlayingMovies: mockGetNowPlayingMovies);
  });
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group("Movie List Bloc", () {
    group("Now Playing", () {
      blocTest<NowPlayingMovieListBloc, MovieListState>(
        "should emit nowPlayingLoading and nowPlayiongLoaded when get data is successfull",
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return nowPlayingMovieListBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingMovies()),
        expect: () => [
          MovieNowPlayingLoading(),
          MovieNowPlayingHasData(tMovieList),
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        },
      );
      blocTest<NowPlayingMovieListBloc, MovieListState>(
        "should emit nowPlayingLoading and nowPlayiongError when get data is unsuccessfully",
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('failed')));

          return nowPlayingMovieListBloc;
        },
        act: (bloc) => bloc.add(FetchNowPlayingMovies()),
        expect: () => [
          MovieNowPlayingLoading(),
          const MovieNowPlayingError('failed'),
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        },
      );
    });

    group("Top Rated", () {
      blocTest<TopRatedMovieListBloc, MovieListState>(
        "should emit topRatedLoading and topRatedLoaded when get data is successfull",
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return topRatedMovieListBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedMovies()),
        expect: () => [
          MovieTopRatedLoading(),
          MovieTopRatedHasData(tMovieList),
        ],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );
      blocTest<TopRatedMovieListBloc, MovieListState>(
        "should emit topRatedLoading and topRatedError when get data is unsuccessfully",
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure("failed")));

          return topRatedMovieListBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedMovies()),
        expect: () => [
          MovieTopRatedLoading(),
          const MovieTopRatedError('failed'),
        ],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );

    });

    group("Popular", () {
      blocTest<PopularMovieListBloc, MovieListState>(
        "should emit popularLoading and popularLoaded when get data is successfull",
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return popularMovieListBloc;
        },
        act: (bloc) => bloc.add(FetchPopularMovies()),
        expect: () => [
          MoviePopularLoading(),
          MoviePopularHasData(tMovieList),
        ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        },
      );
       blocTest<PopularMovieListBloc, MovieListState>(
        "should emit popularLoading and popularError when get data is unsuccessfully",
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(DatabaseFailure("failed")));

          return popularMovieListBloc;
        },
        act: (bloc) => bloc.add(FetchPopularMovies()),
        expect: () => [
          MoviePopularLoading(),
          MoviePopularError("failed"),
        ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        },
      );
    });
  });
}
