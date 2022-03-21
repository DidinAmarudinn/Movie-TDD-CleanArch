import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recomendation.dart';
import 'package:flutter/foundation.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
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

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecomendations getTvSeriesRecomendations;
  TvSeriesDetailNotifier(
      {required this.getTvSeriesDetail,
      required this.getTvSeriesRecomendations});

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
}
