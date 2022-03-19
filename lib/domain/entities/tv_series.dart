import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  TvSeries({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originalName,
    required this.originCountry,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  TvSeries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;


  @override
  List<Object?> get props => [
        backdropPath,
        name,
        originCountry,
        originalLanguage,
        originalName,
        firstAirDate,
        genreIds,
        id,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
