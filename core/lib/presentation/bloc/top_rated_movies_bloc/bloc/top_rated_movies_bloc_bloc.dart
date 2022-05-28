import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movies_bloc_event.dart';
part 'top_rated_movies_bloc_state.dart';

class TopRatedMoviesBlocBloc
    extends Bloc<TopRatedMoviesBlocEvent, TopRatedMoviesBlocState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMoviesBlocBloc({required this.getTopRatedMovies})
      : super(TopRatedMoviesEmpty()) {
    on<TopRatedMoviesBlocEvent>((event, emit) async {
      emit(TopRatedMoviesLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) => emit(TopRateMoviesError(failure.message)),
        (movies) => emit(TopRateMoviesHasData(movies)),
      );
    });
  }
}
