import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesLocalDataSource localDataSource;
  late MockTvSeriesRemoteDataSource remoteDataSource;

  setUp(() {
    localDataSource = MockTvSeriesLocalDataSource();
    remoteDataSource = MockTvSeriesRemoteDataSource();
    repository = TvSeriesRepositoryImpl(
        remoteDataSource: remoteDataSource, localDataSource: localDataSource);
  });

  final tTvSeriesModel = TvSeriesModel(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1, 2],
      id: 1,
      name: "name",
      originalName: "originalName",
      originCountry: ["en"],
      originalLanguage: "originalLanguage",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 9,
      voteCount: 100);

  final tTvSeries = TvSeries(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1, 2],
      id: 1,
      name: "name",
      originalName: "originalName",
      originCountry: ["en"],
      originalLanguage: "originalLanguage",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 9,
      voteCount: 100);
  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];
  group('on air tv series', () {
    test(
      'should return remote data when call to remote data source is successfull',
      () async {
        // arrange
        when(remoteDataSource.getOnAirTvSeries())
            .thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.getOnAirTvSeries();
        // assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      },
    );
    test(
      'should return server failure when the call to remote is unsucessfull',
      () async {
        // arrange
        when(remoteDataSource.getOnAirTvSeries()).thenThrow(ServerException());
        // act
        final result = await repository.getOnAirTvSeries();
        // assert
        verify(remoteDataSource.getOnAirTvSeries());
        expect(result, equals(Left(ServerFailure(''))));
      },
    );
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(remoteDataSource.getOnAirTvSeries())
          .thenThrow(SocketException("failed connect to the network"));
      // act
      final result = await repository.getOnAirTvSeries();
      // assert
      verify(remoteDataSource.getOnAirTvSeries());
      expect(result,
          equals(Left(ConnectionFailure('failed connect to the network'))));
    });
  });
  group('top rated', () {
    test(
      'should return remote data when call to remote data source is successfull',
      () async {
        // arrange
        when(remoteDataSource.getTopRatedTvSeries())
            .thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      },
    );
    test(
      'should return server failure when the call to remote is unsucessfull',
      () async {
        // arrange
        when(remoteDataSource.getTopRatedTvSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        verify(remoteDataSource.getTopRatedTvSeries());
        expect(result, equals(Left(ServerFailure(''))));
      },
    );
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(remoteDataSource.getTopRatedTvSeries())
          .thenThrow(SocketException("failed connect to the network"));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      verify(remoteDataSource.getTopRatedTvSeries());
      expect(result,
          equals(Left(ConnectionFailure('failed connect to the network'))));
    });
  });

  group('popular tv series', () {
    test(
      'should return remote data when call to remote data source is successfull',
      () async {
        // arrange
        when(remoteDataSource.getPopularTvSeries())
            .thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      },
    );
    test(
      'should return server failure when the call to remote is unsucessfull',
      () async {
        // arrange
        when(remoteDataSource.getPopularTvSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        verify(remoteDataSource.getPopularTvSeries());
        expect(result, equals(Left(ServerFailure(''))));
      },
    );
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(remoteDataSource.getPopularTvSeries())
          .thenThrow(SocketException("failed connect to the network"));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      verify(remoteDataSource.getPopularTvSeries());
      expect(result,
          equals(Left(ConnectionFailure('failed connect to the network'))));
    });
  });

  // tv series detail

  final tTvSeriesDetailModel = TvSeriesDetailModel(
    adult: false,
    backdropPath: 'backdropPath',
    episodeRunTime: [1, 2],
    firstAirDate: 'firstAirDate',
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: "homepage",
    id: 2,
    inProduction: false,
    languages: ["en"],
    lastAirDate: "lastAirDate",
    name: "name",
    numberOfEpisodes: 2,
    numberOfSeasons: 2,
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 9.0,
    posterPath: "posterPath",
    seasons: [
      SeasonModel(
          airDate: "airDate",
          episodeCount: 1,
          id: 1,
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          seasonNumber: 1)
    ],
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 2,
    voteCount: 200,
  );

  group('tv series detail', () {
    final tId = 1;
    test(
      'should return remote data when call to remote data source is successfull',
      () async {
        // arrange
        when(remoteDataSource.getDetailTvSeries(tId))
            .thenAnswer((_) async => tTvSeriesDetailModel);
        // act
        final result = await repository.getDetailTvSeries(tId);
        // assert
        expect(result, equals(Right(testTvSeriesDetail)));
      },
    );
    test(
      'should return server failure when the call to remote is unsucessfull',
      () async {
        // arrange
        when(remoteDataSource.getDetailTvSeries(tId))
            .thenThrow(ServerException());
        // act
        final result = await repository.getDetailTvSeries(tId);
        // assert
        verify(remoteDataSource.getDetailTvSeries(tId));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(remoteDataSource.getDetailTvSeries(tId))
          .thenThrow(SocketException("failed connect to the network"));
      // act
      final result = await repository.getDetailTvSeries(tId);
      // assert
      verify(remoteDataSource.getDetailTvSeries(tId));
      expect(result,
          equals(Left(ConnectionFailure('failed connect to the network'))));
    });
  });

  group('get tv series recommendations', () {
    final tMovieList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data tv series list when the call is successful',
        () async {
      // arrange
      when(remoteDataSource.getTvSeriesRecomendation(tId))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await repository.getTvSeriesRecomendations(tId);
      // assert
      verify(remoteDataSource.getTvSeriesRecomendation(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test('should return server failure when the call to remote is unsucessfull',
        () async {
      // arrange
      when(remoteDataSource.getTvSeriesRecomendation(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesRecomendations(tId);
      // assertbuild runner
      verify(remoteDataSource.getTvSeriesRecomendation(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(remoteDataSource.getTvSeriesRecomendation(tId))
          .thenThrow(SocketException('failed connect to the network'));
      // act
      final result = await repository.getTvSeriesRecomendations(tId);
      // assert
      verify(remoteDataSource.getTvSeriesRecomendation(tId));
      expect(result,
          equals(Left(ConnectionFailure('failed connect to the network'))));
    });
  });

  group('search tv series', () {
    final tQuery = "peaky blinders";
    test(
      'should return list tv series when call to remote data source is successfull',
      () async {
        // arrange
        when(remoteDataSource.searchTvSerie(tQuery))
            .thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.searhcTvSeries(tQuery);
        // assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      },
    );
    test(
      'should return server failure when the call to remote is unsucessfull',
      () async {
        // arrange
        when(remoteDataSource.searchTvSerie(tQuery))
            .thenThrow(ServerException());
        // act
        final result = await repository.searhcTvSeries(tQuery);
        // assert
        verify(remoteDataSource.searchTvSerie(tQuery));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(remoteDataSource.searchTvSerie(tQuery))
          .thenThrow(SocketException("failed connect to the network"));
      // act
      final result = await repository.searhcTvSeries(tQuery);
      // assert
      verify(remoteDataSource.searchTvSerie(tQuery));
      expect(result,
          equals(Left(ConnectionFailure('failed connect to the network'))));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(localDataSource.insertTvSeriesToWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result =
          await repository.saveWatchlistTvSeries(testTvSeriesDetail2);
      // assert
      expect(result, Right('Added to Watchlist'));
    });
    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(localDataSource.insertTvSeriesToWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException("Failed to add watchlist"));
      // act
      final result =
          await repository.saveWatchlistTvSeries(testTvSeriesDetail2);
      // assert
      expect(result, Left(DatabaseFailure("Failed to add watchlist")));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(localDataSource.removeTvSeriesFromWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result =
          await repository.removeWatchlistTvSeries(testTvSeriesDetail2);
      // assert
      expect(result, Right('Added to Watchlist'));
    });
    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(localDataSource.removeTvSeriesFromWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException("Failed to add watchlist"));
      // act
      final result =
          await repository.removeWatchlistTvSeries(testTvSeriesDetail2);
      // assert
      expect(result, Left(DatabaseFailure("Failed to add watchlist")));
    });
  });

  group('get watchlist status', () {
    final tId = 1;
    test(
      'should return watch status true whether data is found',
      () async {
        // arrange
        when(localDataSource.getTvSeriesById(tId))
            .thenAnswer((_) async => testTvSeriesTable);
        // act
        final result = await repository.isTvSeriesAddedToWathclist(tId);
        // assert
        expect(result, true);
      },
    );
    test(
      'should return watch status false weathed data is not found',
      () async {
        // arrange
        when(localDataSource.getTvSeriesById(tId))
            .thenAnswer((_) async => null);
        // act
        final result = await repository.isTvSeriesAddedToWathclist(tId);
        // assert
        expect(result, false);
      },
    );
  });

  group('get watchlist tv series', () {
    test(
      'should return list tv series ',
      () async {
        // arrange
        when(localDataSource.getWatchListTvSeries()).thenAnswer((_) async => [testTvSeriesTable]);
        // act
        final result = await repository.getTvSeriesWatchlist();
        // assert
        final resultList = result.getOrElse(() => [],);
        expect(resultList,[testWatchlistTvSeries]);
      },
    );
  });
}
