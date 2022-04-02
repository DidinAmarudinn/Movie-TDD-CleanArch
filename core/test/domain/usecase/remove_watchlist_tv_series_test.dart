import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';


void main() {
  late RemoveWatchlistTvSeries removeWatchlistTvSeries;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    removeWatchlistTvSeries = RemoveWatchlistTvSeries(repository);
  });

  test(
    'should remove watchlist from repository',
    () async {
      // arrange
      when(repository.removeWatchlistTvSeries(testTvSeriesDetail))
          .thenAnswer((_) async => Right("Removed from watchlist"));
      // act
      final result = await removeWatchlistTvSeries.execute(testTvSeriesDetail);
      // assert
      expect(result, Right("Removed from watchlist"));

    },
  );
}
