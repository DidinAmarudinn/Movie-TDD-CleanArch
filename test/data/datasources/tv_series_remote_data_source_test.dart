import 'dart:convert';
import 'dart:io';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group("On Air Tv Series", () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
      json.decode(
        readJson("dummy_data/on_air_tv_series.json"),
      ),
    ).tvSeriesList;
    test(
      'should return list tv series model when status code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                readJson('dummy_data/on_air_tv_series.json'), 200));
        // act
        final result = await dataSource.getOnAirTvSeries();
        // assert

        expect(result, equals(tTvSeriesList));
      },
    );
    test(
      'should return server exception wehn status code is 404',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getOnAirTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group("Popular Tv Series", () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
      json.decode(
        readJson("dummy_data/popular_tv_series.json"),
      ),
    ).tvSeriesList;
    test(
      'should return list tv series model when status code 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/popular?$API_KEY")))
            .thenAnswer((_) async => http.Response(
                readJson("dummy_data/popular_tv_series.json"), 200));
        // act
        final result = await dataSource.getPopularTvSeries();
        // assert
        expect(result, equals(tTvSeriesList));
      },
    );
    test(
      'should return server exception wehn status code 404',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/popular?$API_KEY")))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getPopularTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group("Top Rated Tv Series", () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
      json.decode(
        readJson("dummy_data/top_rated_tv_series.json"),
      ),
    ).tvSeriesList;
    test(
      'should return list tv series model when status code 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/top_rated?$API_KEY")))
            .thenAnswer((_) async => http.Response(
                readJson("dummy_data/top_rated_tv_series.json"), 200));
        // act
        final result = await dataSource.getTopRatedTvSeries();
        // assert
        expect(result, equals(tTvSeriesList));
      },
    );
    test(
      'should return server exception wehn status code 404',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/top_rated?$API_KEY")))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTopRatedTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
  group("Detail Tv Series", () {
    final tId = 1;
    final tTvSeriesDetail = TvSeriesDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')));
    test(
      'should return tv series detail when status code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                    readJson("dummy_data/tv_series_detail.json"), 200,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // act
        final result = await dataSource.getDetailTvSeries(tId);
        // assert
        expect(result, equals(tTvSeriesDetail));
      },
    );
    test(
      'should return server exception when status code is 404',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                  "Not Found",
                  404,
                ));
        // act
        final result = dataSource.getDetailTvSeries(tId);
        // assert
        expect(() => result, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get Recomendations Tv Series', () {
    final tId = 1;
    final tTvSeriesList = TvSeriesResponse.fromJson(
      json.decode(
        readJson("dummy_data/tv_series_recomendations.json"),
      ),
    ).tvSeriesList;
    test(
      'should return list recomendations when status code is 200',
      () async {
        // arrange
        when(mockHttpClient
                .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                readJson("dummy_data/tv_series_recomendations.json"), 200));
        // act
        final result = await dataSource.getTvSeriesRecomendation(tId);
        // assert
        expect(result, equals(tTvSeriesList));
      },
    );
    test(
      'should return server exception when status code is 404',
      () async {
        // arrange
        when(mockHttpClient
                .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
            .thenAnswer((_) async => http.Response("Not Found", 404));
        // act
        final call = dataSource.getTvSeriesRecomendation(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Search Tv Series', () {
    final tSearchResult = TvSeriesResponse.fromJson(
      json.decode(
        readJson("dummy_data/search_peaky_blinders_tv_series.json"),
      ),
    ).tvSeriesList;
    final tQuery = "Peaky Blinders";
    test(
      'should return list tv series when status code is 200',
      () async {
        // arrange
        when(mockHttpClient
                .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
            .thenAnswer((_) async => http.Response(
                readJson("dummy_data/search_peaky_blinders_tv_series.json"),
                200));
        // act
        final result = await dataSource.searchTvSerie(tQuery);
        // assert
        expect(result, equals(tSearchResult));
      },
    );

    test(
      'should return server exception when status code is 404',
      () async {
        // arrange
         when(mockHttpClient
                .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
            .thenAnswer((_) async => http.Response(
               "Not Found",
                404));
        // act
        final call = dataSource.searchTvSerie(tQuery);
        // assert
        expect(()=> call, throwsA(isA<ServerException>()));
      },
    );
  });
}
