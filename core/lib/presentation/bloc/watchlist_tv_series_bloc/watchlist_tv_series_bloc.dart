import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchListTvSeries getWatchListTvSeries;
  WatchlistTvSeriesBloc({required this.getWatchListTvSeries}) : super(WatchlistTvSeriesEmpty()) {
    on<WatchlistTvSeriesEvent>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      final result = await getWatchListTvSeries.execute();
      result.fold(
        (failure) => emit(WatchlistTvSeriesError(failure.message)),
        (tvSeries) => emit(WatchlistTvSeriesHasData(tvSeries)),
      );
    });
  }
}
