
import 'package:flutter/foundation.dart';

import '../../core.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/entities/tv_series_detail.dart';
import '../../domain/usecases/get_tv_series_detail.dart';
import '../../domain/usecases/get_tv_series_recomendation.dart';
import '../../domain/usecases/get_watchlist_status_tv_series.dart';
import '../../domain/usecases/remove_watchlist_tv_series.dart';
import '../../domain/usecases/save_watchlist_tv_series.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecomendations getTvSeriesRecomendations;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;
  final GetWatchlistStatusTvSeries getWatchlistStatusTvSeries;
  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecomendations,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
    required this.getWatchlistStatusTvSeries,
  });

  late TvSeriesDetail _seriesDetail;
  TvSeriesDetail get seriesDetail => _seriesDetail;

  var _listRecomendations = <TvSeries>[];
  List<TvSeries> get listRecomendations => _listRecomendations;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _messsage = "";
  String get message => _messsage;

  RequestState _stateRecomendation = RequestState.Empty;
  RequestState get stateRecomendation => _stateRecomendation;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await getTvSeriesDetail.execute(id);
    final resultRecomendations = await getTvSeriesRecomendations.execute(id);
    print(result);
    result.fold((failure) {
      _state = RequestState.Error;
      _messsage = failure.message;
      notifyListeners();
    }, (seriesDetail) {
      _stateRecomendation = RequestState.Loading;
      _seriesDetail = seriesDetail;
      notifyListeners();
      resultRecomendations.fold((failure) {
        _stateRecomendation = RequestState.Error;
        _messsage = failure.message;
      }, (listSeries) {
        _listRecomendations = listSeries;
        _stateRecomendation = RequestState.Loaded;
      });
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

  String _watchlistMessage = "";
  String get watchListMessage => _watchlistMessage;

  Future<void> addToWatchlist(TvSeriesDetail detail) async {
    final result = await saveWatchlistTvSeries.execute(detail);
    result.fold((failure) {
      _watchlistMessage = failure.message;
      notifyListeners();
    }, (successMessage) {
      _watchlistMessage = successMessage;
      notifyListeners();
    });
    await loadWatchlistStatus(detail.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail detail) async {
    final result = await removeWatchlistTvSeries.execute(detail);
    result.fold((failure) {
      _watchlistMessage = failure.message;
      notifyListeners();
    }, (successMessage) {
      _watchlistMessage = successMessage;
      notifyListeners();
    });
    await loadWatchlistStatus(detail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistStatusTvSeries.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
