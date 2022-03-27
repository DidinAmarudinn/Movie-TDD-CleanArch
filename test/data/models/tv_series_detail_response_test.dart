import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesDetailModel = TvSeriesDetailModel(
    adult: false,
    backdropPath: 'backdropPath',
    episodeRunTime: [1, 2],
    firstAirDate: 'firstAirDate',
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: "homepage",
    id: 2,
    inProduction: false,
    languages: ["en"],
    lastAirDate: "lastAirDate",
    name: "name",
    numberOfEpisodes: 2,
    numberOfSeasons: 2,
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 9.0,
    posterPath: "posterPath",
    seasons: [
      SeasonModel(
          airDate: "airDate",
          episodeCount: 1,
          id: 1,
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          seasonNumber: 1)
    ],
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 2,
    voteCount: 200,
  );

  group('from json', () {
    test(
      'should return a valid model from json ',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(readJson("dummy_data/tv_series_detail.json"));
        // act
        final result = TvSeriesDetailModel.fromJson(jsonMap);
        // assert
        expect(result, equals(tTvSeriesDetailModel));
      },
    );
  });

  group('to json', () {
    test(
      'should return json map with proper data',
      () async {
        // arrange
        final expectedMap = {
          "adult": false,
          "backdrop_path": "backdropPath",
          "episode_run_time": [1, 2],
          "first_air_date": "firstAirDate",
          "genres": [
            {"id": 1, "name": "Action"}
          ],
          "homepage": "homepage",
          "id": 2,
          "in_production": false,
          "languages": ["en"],
          "last_air_date": "lastAirDate",
          "name": "name",
          "number_of_episodes": 2,
          "number_of_seasons": 2,
          "original_language": "originalLanguage",
          "original_name": "originalName",
          "overview": "overview",
          "popularity": 9.0,
          "poster_path": "posterPath",
          "seasons": [
            {
              "air_date": "airDate",
              "episode_count": 1,
              "id": 1,
              "name": "name",
              "overview": "overview",
              "poster_path": "posterPath",
              "season_number": 1
            }
          ],
          "status": "status",
          "tagline": "tagline",
          "type": "type",
          "vote_average": 2,
          "vote_count": 200
        };
        // act
        final result = tTvSeriesDetailModel.toJson();
        // assert
        expect(result, equals(expectedMap));
      },
    );
  });
}
