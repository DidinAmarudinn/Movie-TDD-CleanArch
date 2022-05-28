import 'package:core/presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../core.dart';
import '../provider/watchlist_movie_notifier.dart';
import '../widgets/movie_card_list.dart';

class WatchlistMoviePage extends StatelessWidget {
  const WatchlistMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
      builder: (context, state) {
        if (state is WatchlistMoviesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WatchlistMoviesHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return MovieCard(movie);
            },
            itemCount: state.movies.length,
          );
        } else if (state is WatchlistMoviesError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
