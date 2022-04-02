import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late GetPopularTvSeries getPopularTvSeries;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp((){
    mockTvSeriesRepository = MockTvSeriesRepository();
    getPopularTvSeries = GetPopularTvSeries(mockTvSeriesRepository);
  });

  List<TvSeries> tListTvSeries = [];

  test(
    'should get lust popular tv series from repository',
    () async {
      // arrange
      when(mockTvSeriesRepository.getPopularTvSeries()).thenAnswer((_) async => Right(tListTvSeries));
      // act
      final result = await getPopularTvSeries.execute();
      // assert
      expect(result, Right(tListTvSeries));
    },
  );

}