import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1, 2],
      id: 1,
      name: "name",
      originalName: "originalName",
      originCountry: ["en"],
      originalLanguage: "originalLanguage",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 9,
      voteCount: 100);

  final tTvSeries = TvSeries(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      genreIds: [1, 2],
      id: 1,
      name: "name",
      originalName: "originalName",
      originCountry: ["en"],
      originalLanguage: "originalLanguage",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 9,
      voteCount: 100);

      test(
        'should a subsclass of entity tv series',
        () async {
          // act
          final result =  tTvSeriesModel.toEntity();
          // assert
          expect(result, equals(tTvSeries));
        },
      );
}
