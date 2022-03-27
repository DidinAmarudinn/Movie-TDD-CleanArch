import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/tv_series.dart';

class WatchlistTvSeriesNotifier extends ChangeNotifier{
  var _watchlistTvSeries = <TvSeries>[];
  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  String _message = "";
  String get message => _message;

  RequestState _requestState = RequestState.Empty;
  RequestState get requestState => _requestState;

  final GetWatchListTvSeries getWatchListTvSeries;
  WatchlistTvSeriesNotifier({required this.getWatchListTvSeries});
 

  Future<void> fetchWatchlistTvSeries()async{
    _requestState = RequestState.Loading;
    notifyListeners();
    final result = await getWatchListTvSeries.execute();
    result.fold((failure){
      _requestState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (watchlistTvSeries){
      _watchlistTvSeries = watchlistTvSeries;
      _requestState = RequestState.Loaded;
      notifyListeners();
    });

  }
}