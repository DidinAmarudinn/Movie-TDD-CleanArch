
import 'package:core/domain/usecases/save_watchlist_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late SaveWatchlistTvSeries saveWatchlistTvSeries;
  late MockTvSeriesRepository repository;

  setUp((){
    repository = MockTvSeriesRepository();
    saveWatchlistTvSeries = SaveWatchlistTvSeries(repository);
  });

  test(
    'should save watchlist from repository',
    () async {
      // arrange
      when(repository.saveWatchlistTvSeries(testTvSeriesDetail)).thenAnswer((_) async=> Right("Added to watchlist"));
      // act
      final result = await saveWatchlistTvSeries.execute(testTvSeriesDetail);
      // assert
      expect(result, Right("Added to watchlist"));
    },
  );
}