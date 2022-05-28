import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/movie_list/bloc/movie_list_bloc.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core.dart';
import '../../domain/entities/movie.dart';
import '../widgets/heading_with_navigator.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<PopularMovieListBloc>(context).add(FetchPopularMovies());
      BlocProvider.of<NowPlayingMovieListBloc>(context)
          .add(FetchNowPlayingMovies());
      BlocProvider.of<TopRatedMovieListBloc>(context)
          .add(FetchTopRatedMovies());
    });
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMovieListBloc, MovieListState>(
                  builder: (context, state) {
                if (state is MovieNowPlayingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieNowPlayingHasData) {
                  return MovieList(state.movies);
                } else if (state is MovieNowPlayingError) {
                  return Text(state.message);
                } else {
                  return const SizedBox();
                }
              }),
              BuildHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMovieListBloc, MovieListState>(
                  builder: (context, state) {
                if (state is MoviePopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MoviePopularHasData) {
                  return MovieList(state.movies);
                } else if (state is MoviePopularError) {
                  return Text(state.message);
                } else {
                  return const SizedBox();
                }
              }),
              BuildHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMovieListBloc, MovieListState>(
                  builder: (context, state) {
                if (state is MovieTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieTopRatedHasData) {
                  return MovieList(state.movies);
                } else if (state is MovieTopRatedError) {
                  return Text(state.message);
                } else {
                  return const SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
