import 'dart:convert';

import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      firstAirDate: "2003-10-21",
      genreIds: [18],
      id: 11250,
      name: "Pasión de gavilanes",
      originalName: "Pasión de gavilanes",
      originCountry: ["CO"],
      originalLanguage: "es",
      overview:
          "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
      popularity: 2311.573,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      voteAverage: 7.7,
      voteCount: 1752);
  final tTvSeriesResponse = TvSeriesResponse(tvSeriesList: [tTvSeriesModel]);

  group('from json', () {
    test(
      'should return a valid model from JSON',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(readJson("dummy_data/on_air_tv_series.json"));

        // act
        final result = TvSeriesResponse.fromJson(jsonMap);
        // assert
        expect(result, equals(tTvSeriesResponse));
      },
    );
  });

  group("to json", () {
    test(
      'should return a valid JSON map containing proper data',
      () async {
        // arrange
        final expectedMap = {
        
          "results": [
            {
              "backdrop_path": "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
              "first_air_date": "2003-10-21",
              "genre_ids": [18],
              "id": 11250,
              "name": "Pasión de gavilanes",
              "origin_country": ["CO"],
              "original_language": "es",
              "original_name": "Pasión de gavilanes",
              "overview":
                  "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
              "popularity": 2311.573,
              "poster_path": "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
              "vote_average": 7.7,
              "vote_count": 1752
            }
          ],
  
        };
        // act
        final result = tTvSeriesResponse.toJson(); 
        // assert
        expect(result, equals(expectedMap));
      },
    );
  });
}
