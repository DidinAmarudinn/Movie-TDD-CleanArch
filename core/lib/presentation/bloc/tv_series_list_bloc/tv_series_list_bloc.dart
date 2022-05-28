import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_on_air_tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_list_event.dart';
part 'tv_series_list_state.dart';

class OnAirTvSeriesListBloc extends Bloc<TvSeriesListEvent, TvSeriesListState> {
  final GetOnAirTvSeries getOnAirTvSeries;
  OnAirTvSeriesListBloc({required this.getOnAirTvSeries})
      : super(TvSeriesListEmpty()) {
      on<FetchOnAirTvSeries>((event, emit) async {
        emit(TvSeriesOnAirLoading());
        final result = await getOnAirTvSeries.execute();
        result.fold((failure) {
          emit(TvSeriesOnAirError(failure.message));
        }, (movies) {
          emit(TvSeriesOnAirHasData(movies));
        });
      });
    
  }
}


class PopularTvSeriesListBloc extends Bloc<TvSeriesListEvent, TvSeriesListState> {
  final GetPopularTvSeries getPopularTvSeries;
  PopularTvSeriesListBloc({required this.getPopularTvSeries})
      : super(TvSeriesListEmpty()) {
      on<FetchPopularTvSeries>((event, emit) async {
        emit(TvSeriesPopularLoading());
        final result = await getPopularTvSeries.execute();
        result.fold((failure) {
          emit(TvSeriesPopularError(failure.message));
        }, (movies) {
          emit(TvSeriesPopularHasData(movies));
        });
      });
    
  }
}


class TopRatedTvSeriesListBloc extends Bloc<TvSeriesListEvent, TvSeriesListState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;
  TopRatedTvSeriesListBloc({required this.getTopRatedTvSeries})
      : super(TvSeriesListEmpty()) {
      on<FetchTopRatedTvSeries>((event, emit) async {
        emit(TvSeriesTopRatedLoading());
        final result = await getTopRatedTvSeries.execute();
        result.fold((failure) {
          emit(TvSeriesTopRatedError(failure.message));
        }, (movies) {
          emit(TvSeriesTopRatedHasData(movies));
        });
      });
    
  }
}