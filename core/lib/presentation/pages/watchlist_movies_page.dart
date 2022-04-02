
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core.dart';
import '../provider/watchlist_movie_notifier.dart';
import '../widgets/movie_card_list.dart';

class WatchlistMoviePage extends StatelessWidget {
  const WatchlistMoviePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistMovieNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.watchlistMovies[index];
                  return MovieCard(movie);
                },
                itemCount: data.watchlistMovies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        
      
    );
  }
}