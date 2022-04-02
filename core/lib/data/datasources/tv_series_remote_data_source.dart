import 'dart:convert';
import '../../utils/exception.dart';
import '../models/tv_series_detail_model.dart';
import '../models/tv_series_model.dart';
import 'package:http/http.dart' as http;
import '../models/tv_series_response.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getOnAirTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<List<TvSeriesModel>> searchTvSerie(String query);
  Future<TvSeriesDetailModel> getDetailTvSeries(int id);
  Future<List<TvSeriesModel>> getTvSeriesRecomendation(int id);
}

class TvSeriesRemoteDataSourceImpl extends TvSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';
  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});
  @override
  Future<List<TvSeriesModel>> getOnAirTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSerie(String query)async {
    final response = await client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));
    if(response.statusCode == 200){
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailModel> getDetailTvSeries(int id)async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
    if(response.statusCode == 200){
      return TvSeriesDetailModel.fromJson(json.decode(response.body));
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecomendation(int id) async{
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));
    if(response.statusCode == 200){
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    }else{
      throw ServerException();
    }
  }
}
