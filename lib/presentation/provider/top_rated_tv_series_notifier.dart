import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter/foundation.dart';

class TopRatedTvSeriesNotifier extends ChangeNotifier {
  var _tvSeries = <TvSeries>[];

  List<TvSeries> get tvSeries => _tvSeries;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = "";
  String get message => _message;

  final GetTopRatedTvSeries getTopRatedTvSeries;
  TopRatedTvSeriesNotifier({required this.getTopRatedTvSeries});

  Future<void> fetchPopularTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await getTopRatedTvSeries.execute();
    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeries) {
      _state = RequestState.Loaded;
      _tvSeries = tvSeries;
      notifyListeners();
    });
  }
}
