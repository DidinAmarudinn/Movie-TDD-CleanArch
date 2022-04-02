import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tv_series.dart';
import '../entities/tv_series_detail.dart';

abstract class TvSeriesRepository{
  Future<Either<Failure, List<TvSeries>>> getOnAirTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, List<TvSeries>>> searhcTvSeries(String query);
  Future<Either<Failure, TvSeriesDetail>> getDetailTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecomendations(int id);
  Future<Either<Failure, String>> saveWatchlistTvSeries(TvSeriesDetail tvSeriesDetail);
  Future<Either<Failure, String>> removeWatchlistTvSeries(TvSeriesDetail tvSeriesDetail);
  Future<bool> isTvSeriesAddedToWathclist(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesWatchlist();
}