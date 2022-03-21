import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvSeriesRecomendations{
  final TvSeriesRepository repository;

  GetTvSeriesRecomendations(this.repository);

  Future<Either<Failure,List<TvSeries>>> execute(int id){
    return repository.getTvSeriesRecomendations(id);
  }

}