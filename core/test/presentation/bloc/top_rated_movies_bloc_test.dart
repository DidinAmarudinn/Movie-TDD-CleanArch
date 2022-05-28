import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/top_rated_movies_bloc/bloc/top_rated_movies_bloc_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';
@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBlocBloc topRatedMoviesBlocBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp((){
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBlocBloc = TopRatedMoviesBlocBloc(getTopRatedMovies: mockGetTopRatedMovies);
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


  group("TopRated Movies Bloc", (){
    blocTest<TopRatedMoviesBlocBloc, TopRatedMoviesBlocState>(
        "should emit popularMoviesLoading and popularMoviesLoaded when get data is successfull",
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
        
          return topRatedMoviesBlocBloc;
        },
        act: (bloc) => bloc.add(const TopRatedMoviesBlocEvent()),
        expect: () => [
          TopRatedMoviesLoading(),
          TopRateMoviesHasData(tMovieList)
          
        ],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );
       blocTest<TopRatedMoviesBlocBloc, TopRatedMoviesBlocState>(
        "should emit popularMoviesLoading and popularMoviesError  when get data is unsuccessfully",
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure("failed")));
        
          return topRatedMoviesBlocBloc;
        },
        act: (bloc) => bloc.add(const TopRatedMoviesBlocEvent()),
        expect: () => [
          TopRatedMoviesLoading(),
          const TopRateMoviesError("failed")
        ],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );
  });
}