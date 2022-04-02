
import 'package:flutter/foundation.dart';

import '../../core.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_on_air_tv_series.dart';
import '../../domain/usecases/get_popular_tv_series.dart';
import '../../domain/usecases/get_top_rated_tv_series.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _popularTvSeries = <TvSeries>[];

  List<TvSeries> get populatTvSeries => _popularTvSeries;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _onAirTvSeries = <TvSeries>[];
  List<TvSeries> get onAirTvSeries => _onAirTvSeries;

  RequestState _onAirState = RequestState.Empty;
  RequestState get onAirState => _onAirState;

  var _topRatedTvSeries = <TvSeries>[];
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = "";
  String get message => _message;

  final GetOnAirTvSeries getOnAirTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesListNotifier({
    required this.getOnAirTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  });

  Future<void> fetchOnAirTvSeries() async {
    _onAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTvSeries.execute();
    result.fold((failure) {
      _message = failure.message;
      _onAirState = RequestState.Error;
      notifyListeners();
    }, (tvSeriesData) {
      _onAirTvSeries = tvSeriesData;
      _onAirState = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTvSeries() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold((failure) {
      _message = failure.message;
      _popularState = RequestState.Error;
      notifyListeners();
    }, (tvSeriesData) {
      _popularTvSeries = tvSeriesData;
      _popularState = RequestState.Loaded;
      notifyListeners();
    });
  }

   Future<void> fetchTopRatedTvSeries() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold((failure) {
      _message = failure.message;
      _topRatedState = RequestState.Error;
      notifyListeners();
    }, (tvSeriesData) {
      _topRatedTvSeries = tvSeriesData;
      _topRatedState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
