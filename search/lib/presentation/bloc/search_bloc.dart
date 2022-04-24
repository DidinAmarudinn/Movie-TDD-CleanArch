import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecase/search_movies.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;

  SearchBloc(this.searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;
        print(query);
        emit(SearchLoading());

        final result = await searchMovies.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (movies) {
            emit(SearchHasData(movies));
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
