import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter/foundation.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  late TvSeriesDetail _seriesDetail;
  TvSeriesDetail get seriesDetail => _seriesDetail;

  final GetTvSeriesDetail getTvSeriesDetail;
  TvSeriesDetailNotifier({required this.getTvSeriesDetail});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _messsage = "";
  String get message => _messsage;

  Future<void> fetchTvSeriesDetail(int id) async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await getTvSeriesDetail.execute(id);
    print(result);
    result.fold((failure) {
      _state = RequestState.Error;
      _messsage = failure.message;
      notifyListeners();
    }, (seriesDetail) {
      _seriesDetail = seriesDetail;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
