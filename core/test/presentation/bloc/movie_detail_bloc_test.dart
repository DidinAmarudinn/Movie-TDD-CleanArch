import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();

    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });
  const tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds:const [1, 2, 3],
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
  final tMovies = <Movie>[tMovie];

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  void _arrangeUsecaseDetailFailed() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
  }

  void _arramgeUsecaseRecomendationsFailed() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
  }

  group("Movie detail bloc", () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        "should emit movieloading, recomendationmovieloading, movieloaded and recomendationmovie loaded when data is gotten successfully ",
        build: () {
          _arrangeUsecase();
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchDetailMovie(tId)),
        expect: () => [
              MovieDetailState.initial()
                  .copyWith(movieDetailState: RequestState.Loading),
              MovieDetailState.initial().copyWith(
                  movieDetailState: RequestState.Loaded,
                  movieRecommendationsState: RequestState.Loading,
                  movieDetail: testMovieDetail,
                  message: ''),
              MovieDetailState.initial().copyWith(
                movieDetailState: RequestState.Loaded,
                movieRecommendationsState: RequestState.Loaded,
                movieDetail: testMovieDetail,
                message: '',
                movieRecommendations: tMovies,
              ),
            ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        "should emit movieloading, recomendationsMovieEmpty, movieError when data is unsuccessfully ",
        build: () {
          _arrangeUsecaseDetailFailed();
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchDetailMovie(tId)),
        expect: () => [
              MovieDetailState.initial()
                  .copyWith(movieDetailState: RequestState.Loading),
              MovieDetailState.initial().copyWith(
                  movieDetailState: RequestState.Error,
                  movieRecommendationsState: RequestState.Empty,
                  movieDetail: null,
                  message: 'Server Failure')
            ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
          verify(mockGetMovieDetail.execute(tId));
        });
    blocTest<MovieDetailBloc, MovieDetailState>(
        "should emit movieloading, recomendationmovieloading, movieLoaded and recomendationmovieError when detail movie data data is successful but recomendations movie failed ",
        build: () {
          _arramgeUsecaseRecomendationsFailed();
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchDetailMovie(tId)),
        expect: () => [
              MovieDetailState.initial()
                  .copyWith(movieDetailState: RequestState.Loading),
              MovieDetailState.initial().copyWith(
                  movieDetailState: RequestState.Loaded,
                  movieRecommendationsState: RequestState.Loading,
                  movieDetail: testMovieDetail,
                  message: ''),
              MovieDetailState.initial().copyWith(
                  movieDetailState: RequestState.Loaded,
                  movieRecommendationsState: RequestState.Error,
                  movieDetail: testMovieDetail,
                  movieRecommendations: [],
                  message: 'Server Failure')
            ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
          verify(mockGetMovieDetail.execute(tId));
        });
  });

  group("Watchlist", () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      "shoule emit isAddToWatchlist true",
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
      expect: () =>
          [MovieDetailState.initial().copyWith(isAddedToWatchlist: true)],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(tId));
      },
    );
    group("add to watchlist", () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        "shoule emit watchlist message isAddToWatchlist true",
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Added to Watchlist'));
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(AddToWatchlist(testMovieDetail)),
        expect: () => [
          MovieDetailState.initial().copyWith(
              isAddedToWatchlist: true, watchlistMessage: "Added to Watchlist")
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(tId));
        },
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        "shoule emit watchlist message when add to watchlist failed",
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure("Failed")));
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(AddToWatchlist(testMovieDetail)),
        expect: () =>
            [MovieDetailState.initial().copyWith(watchlistMessage: "Failed")],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(tId));
        },
      );
    });
    group("Remove from watchlist", () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        "should emit watchlist message isAddToWatchlist false",
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Removed from Watchlist'));
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
        expect: () => [
          MovieDetailState.initial().copyWith(
              isAddedToWatchlist: false,
              watchlistMessage: "Removed from Watchlist")
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(tId));
        },
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        "should emit watchlist message when remove from watchlist failed",
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure("Failed")));
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
        expect: () => [
          MovieDetailState.initial()
              .copyWith(isAddedToWatchlist: false, watchlistMessage: "Failed")
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(tId));
        },
      );
    });
  });
}
