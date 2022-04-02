
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

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

  final tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: 'backdropPath',
    episodeRunTime: [1, 2],
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'Action')],
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
      Season(
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


  test(
    'should a subsclass of entity tv series detail',
    () async {
      // arrange
      
      // act
      final result = tTvSeriesDetailModel.toEntity();
      // assert
      expect(result, equals(tTvSeriesDetail));
    },
  );
}
