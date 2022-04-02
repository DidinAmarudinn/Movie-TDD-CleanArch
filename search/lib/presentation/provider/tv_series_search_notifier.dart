
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter/foundation.dart';
import '../../domain/usecase/search_tv_series.dart';

class TvSeriesSearchNotifier extends ChangeNotifier {
  var _tvSeries = <TvSeries>[];

  List<TvSeries> get searchResult => _tvSeries;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = "";
  String get message => _message;

  final SearchTvSeries searchTvSeries;
  TvSeriesSearchNotifier({required this.searchTvSeries});

  Future<void> fetchTvSeriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    print(result);
    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeries) {
      _tvSeries = tvSeries;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
