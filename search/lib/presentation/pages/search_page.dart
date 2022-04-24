import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

import '../provider/movie_search_notifier.dart';

import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';

import '../provider/tv_series_search_notifier.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  final bool isFromMovie;

  const SearchPage({Key? key, this.isFromMovie = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isFromMovie ? 'Search Movie' : "Search Tv Series"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                if (isFromMovie) {
                //  context.read<SearchBloc>().add(OnQueryChanged(query));
                } else {
                  Provider.of<TvSeriesSearchNotifier>(context, listen: false)
                      .fetchTvSeriesSearch(query);
                }
              },
              onChanged: (query){
                
                context.read<SearchBloc>().add(OnQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            isFromMovie
                ? BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchHasData) {
                        final result = state.result;
                        if (result.isNotEmpty) {
                          return Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                final movie = state.result[index];
                                return MovieCard(movie);
                              },
                              itemCount: result.length,
                            ),
                          );
                        } else {
                          return const Text("Movie Not Found");
                        }
                      } else if (state is SearchError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  )
                : Consumer<TvSeriesSearchNotifier>(
                    builder: (context, data, child) {
                      if (data.state == RequestState.Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.state == RequestState.Loaded) {
                        final result = data.searchResult;

                        if (result.isNotEmpty) {
                          return Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                final tvSeries = data.searchResult[index];
                                return TvSeriesCard(tvSeries);
                              },
                              itemCount: result.length,
                            ),
                          );
                        } else {
                          return const Text("Tv Series Not Found");
                        }
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
