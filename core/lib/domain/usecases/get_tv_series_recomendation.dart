import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetTvSeriesRecomendations{
  final TvSeriesRepository repository;

  GetTvSeriesRecomendations(this.repository);

  Future<Either<Failure,List<TvSeries>>> execute(int id){
    return repository.getTvSeriesRecomendations(id);
  }

}