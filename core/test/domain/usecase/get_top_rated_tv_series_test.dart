import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late GetTopRatedTvSeries getTopRatedTvSeries;
  late MockTvSeriesRepository repository;

  setUp((){
    repository = MockTvSeriesRepository();
    getTopRatedTvSeries = GetTopRatedTvSeries(repository);
  });

  List<TvSeries> listTvSeries= [];

 test(
   'should get list of tv series from repository',
   () async {
     // arrange
     when(repository.getTopRatedTvSeries()).thenAnswer((_)async{
      return Right(listTvSeries);
     });
     // act
     final result = await getTopRatedTvSeries.execute();
     // assert
     expect(result, Right(listTvSeries));
   },
 );
}