import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){
  late SearchTvSeries searchTvSeries;
  late MockTvSeriesRepository repository;

  setUp((){
    repository = MockTvSeriesRepository();
    searchTvSeries = SearchTvSeries(repository);
  });

  final tSearchResult = <TvSeries>[];
  final tQuery = "peaky blinders";
  test(
    'should get list tv series from repository',
    () async {
      // arrange
      when(repository.searhcTvSeries(tQuery)).thenAnswer((_) async=> Right(tSearchResult));
      // act
      final result = await searchTvSeries.execute(tQuery);
      // assert
      expect(result, Right(tSearchResult));
    },
  );
}