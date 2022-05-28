
import 'package:core/presentation/bloc/popular_movies_bloc/bloc/popular_movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../core.dart';
import '../provider/popular_movies_notifier.dart';
import '../widgets/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
       BlocProvider.of<PopularMoviesBloc>(context)
          .add(const PopularMoviesEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMoviesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(movie);
                },
                itemCount: state.movies.length,
              );
            } else if (state is PopularMoviesError){
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
