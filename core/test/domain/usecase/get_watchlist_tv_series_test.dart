
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){
  late GetWatchListTvSeries getWatchListTvSeries;
  late MockTvSeriesRepository repository;

  setUp((){
    repository = MockTvSeriesRepository();
    getWatchListTvSeries = GetWatchListTvSeries(repository);
  });

  final tListTvSeries = <TvSeries>[];

  test(
    'should get list tv series from repository',
    () async {
      // arrange
      when(repository.getTvSeriesWatchlist()).thenAnswer((_)async => Right(tListTvSeries));
      // act
      final result = await getWatchListTvSeries.execute();
      // assert
      expect(result, Right(tListTvSeries));
    },
  );
}