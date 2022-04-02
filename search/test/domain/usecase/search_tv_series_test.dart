import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecase/search_tv_series.dart';

import 'search_tv_series_test.mocks.dart';
@GenerateMocks([TvSeriesRepository])
void main(){
  late SearchTvSeries searchTvSeries;
  late MockTvSeriesRepository repository;

  setUp((){
    repository = MockTvSeriesRepository();
    searchTvSeries = SearchTvSeries(repository);
  });

  final tSearchResult = <TvSeries>[];
  const tQuery = "peaky blinders";
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