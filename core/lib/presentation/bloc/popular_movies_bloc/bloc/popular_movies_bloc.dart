import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;
  PopularMoviesBloc({required this.getPopularMovies}) : super(PopularMoviesEmpty()) {
    on<PopularMoviesEvent>((event, emit) async {
      emit(PopularMoviesLoading());
      final result = await getPopularMovies.execute();
      result.fold(
        (failure) => emit(PopularMoviesError(failure.message)),
        (movies) => emit(PopularMoviesHasData(movies)),
      );
    });
  }
}
