import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/presentation/bloc/popular_movies_bloc/bloc/popular_movies_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../provider/popular_movies_notifier_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc =
        PopularMoviesBloc(getPopularMovies: mockGetPopularMovies);
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


  group("Popular Movies Bloc", (){
    blocTest<PopularMoviesBloc, PopularMoviesState>(
        "should emit popularMoviesLoading and popularMoviesLoaded when get data is successfull",
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
        
          return popularMoviesBloc;
        },
        act: (bloc) => bloc.add(const PopularMoviesEvent()),
        expect: () => [
          PopularMoviesLoading(),
          PopularMoviesHasData(tMovieList)
          
        ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        },
      );
       blocTest<PopularMoviesBloc, PopularMoviesState>(
        "should emit popularMoviesLoading and popularMoviesError  when get data is unsuccessfully",
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure("failed")));
        
          return popularMoviesBloc;
        },
        act: (bloc) => bloc.add(const PopularMoviesEvent()),
        expect: () => [
          PopularMoviesLoading(),
          const PopularMoviesError("failed")
        ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        },
      );
  });
}
