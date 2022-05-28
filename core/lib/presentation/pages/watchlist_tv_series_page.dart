import 'package:core/presentation/bloc/watchlist_tv_series_bloc/watchlist_tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/tv_series_card_list.dart';

class WatchlistTvSeriesPage extends StatelessWidget {
  const WatchlistTvSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      builder: (context, state) {
        if (state is WatchlistTvSeriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WatchlistTvSeriesHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tvSeries = state.tvSeries[index];
              return TvSeriesCard(tvSeries);
            },
            itemCount: state.tvSeries.length,
          );
        } else if (state is WatchlistTvSeriesError) {
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
