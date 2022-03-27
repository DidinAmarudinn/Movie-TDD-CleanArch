import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetWatchlistStatusTvSeries{
  final TvSeriesRepository repository;

  GetWatchlistStatusTvSeries(this.repository);
  

  Future<bool> execute(int id)async{
    return await repository.isTvSeriesAddedToWathclist(id);
  }
}