import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_on_air_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnAirTvSeries getOnAirTvSeries;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    getOnAirTvSeries = GetOnAirTvSeries(repository);
  });

  List<TvSeries> tListTvSeries = [];

  test(
    'should get list on air tv series from repository',
    () async {
      // arrange
      when(repository.getOnAirTvSeries()).thenAnswer((_)async  => Right(tListTvSeries));
      // act
      final result = await getOnAirTvSeries.execute();
      // assert
      expect(result, Right(tListTvSeries));
    },
  );
}
