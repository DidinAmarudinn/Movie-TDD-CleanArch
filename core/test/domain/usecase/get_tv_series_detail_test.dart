import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late GetTvSeriesDetail getTvSeriesDetail;
  late MockTvSeriesRepository repository;

  setUp((){
    repository = MockTvSeriesRepository();
    getTvSeriesDetail = GetTvSeriesDetail(repository);
  });

const tId = 1;
test(
  'should get detail tv series from repository',
  () async {
    // arrange
    when(repository.getDetailTvSeries(tId)).thenAnswer((_) async=> Right(testTvSeriesDetail));
    // act
    final result = await getTvSeriesDetail.execute(tId);
    // assert
    expect(result, Right(testTvSeriesDetail));
  },
);

}