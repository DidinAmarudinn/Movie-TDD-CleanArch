import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetOnAirTvSeries {
  final TvSeriesRepository repository;

  GetOnAirTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getOnAirTvSeries();
  }
}
