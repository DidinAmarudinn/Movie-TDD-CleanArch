import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_tv_series_recomendation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late GetTvSeriesRecomendations getTvSeriesRecomendations;
  late MockTvSeriesRepository repository;

  setUp((){
    repository = MockTvSeriesRepository();
    getTvSeriesRecomendations = GetTvSeriesRecomendations(repository);
  });

  const tId = 1;
  final tListRecomendation = <TvSeries>[];

  test(
    'should get list recomendations tv series from repository',
    () async {
      // arrange
      when(repository.getTvSeriesRecomendations(tId)).thenAnswer((_) async => Right(tListRecomendation));
      // act
      final result = await getTvSeriesRecomendations.execute(tId);
      // assert
      expect(result, Right(tListRecomendation));
    },
  );
    
}