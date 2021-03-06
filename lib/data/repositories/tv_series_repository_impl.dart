import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class TvSeriesRepositoryImpl extends TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  final TvSeriesLocalDataSource localDataSource;

  TvSeriesRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});
  @override
  Future<Either<Failure, List<TvSeries>>> getOnAirTvSeries() async {
    try {
      final result = await remoteDataSource.getOnAirTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(""));
    } on SocketException {
      return Left(ConnectionFailure("failed connect to the network"));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    try {
      final result = await remoteDataSource.getPopularTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(""));
    } on SocketException {
      return Left(ConnectionFailure("failed connect to the network"));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(""));
    } on SocketException {
      return Left(ConnectionFailure("failed connect to the network"));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searhcTvSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTvSerie(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('failed connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getDetailTvSeries(int id) async {
    try {
      final result = await remoteDataSource.getDetailTvSeries(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(""));
    } on SocketException {
      return Left(ConnectionFailure('failed connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecomendations(
      int id) async {
    try {
      final result = await remoteDataSource.getTvSeriesRecomendation(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure("failed connect to the network"));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesWatchlist() async {
    final result = await localDataSource.getWatchListTvSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isTvSeriesAddedToWathclist(int id) async {
    final result = await localDataSource.getTvSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTvSeries(
      TvSeriesDetail tvSeriesDetail) async {
    try {
      final result = await localDataSource.removeTvSeriesFromWatchlist(
          TvSeriesTable.fromEntity(tvSeriesDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTvSeries(
      TvSeriesDetail tvSeriesDetail) async {
    try {
      final result = await localDataSource
          .insertTvSeriesToWatchlist(TvSeriesTable.fromEntity(tvSeriesDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }catch(e){
      throw e;
    }
  }
}
