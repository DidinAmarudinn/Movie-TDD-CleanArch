import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class SearchTvSeries{
  final TvSeriesRepository repository;

  SearchTvSeries(this.repository);

  Future<Either<Failure,List<TvSeries>>> execute(String query){
    return repository.searhcTvSeries(query);
  }

}