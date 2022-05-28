import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_series.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;
  PopularTvSeriesBloc({required this.getPopularTvSeries})
      : super(PopularTvSeriesEmpty()) {
    on<PopularTvSeriesEvent>((event, emit) async {
      emit(PopularTvSeriesLoading());
      final result = await getPopularTvSeries.execute();
      result.fold(
        (failure) => emit(PopularTvSeriesError(failure.message)),
        (tvSeries) => emit(PopularTvSeriesHasData(tvSeries)),
      );
    });
  }
}
