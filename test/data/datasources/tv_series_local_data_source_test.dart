import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late TvSeriesLocalDataSource dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp((){
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test(
      'should retrun success message wehn insert data to database is sucess',
      () async {
        // arrange
        when(mockDatabaseHelper.insertTvSeriesWatchlist(testTvSeriesTable)).thenAnswer((_) async => 1);
        // act
        final result = await dataSource.insertTvSeriesToWatchlist(testTvSeriesTable);
        // assert
        expect(result, "Added to Watchlist");
      },
    );
    test(
      'should return database exception when insert data to database is failed',
      () async {
        // arrange
        when(mockDatabaseHelper.insertTvSeriesWatchlist(testTvSeriesTable)).thenThrow(Exception());
        // act
        final call = dataSource.insertTvSeriesToWatchlist(testTvSeriesTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('remove watchlis', () {
    test(
      'should return message when remove data from databas is sucess',
      () async {
        // arrange
        when(mockDatabaseHelper.removeTvSerieWatchlist(testTvSeriesTable)).thenAnswer((_) async => 1);
        // act
        final result = await dataSource.removeTvSeriesFromWatchlist(testTvSeriesTable);
        // assert
        expect(result, "Removed from Watchlist");
      },
    );
    test(
      'should return database exception wehn remove data from database is failed',
      () async {
        // arrange
        when(mockDatabaseHelper.removeTvSerieWatchlist(testTvSeriesTable)).thenThrow(Exception());
        // act
        final call = dataSource.removeTvSeriesFromWatchlist(testTvSeriesTable);
        // assert
        expect(() =>  call, throwsA(isA<DatabaseException>()));
      },
    );
  });
}