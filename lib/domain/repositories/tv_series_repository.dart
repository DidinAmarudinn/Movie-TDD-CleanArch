import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

abstract class TvSeriesRepository{
  Future<Either<Failure, List<TvSeries>>> getOnAirTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, List<TvSeries>>> searhcTvSeries(String query);
  Future<Either<Failure, TvSeriesDetail>> getDetailTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecomendations(int id);
}