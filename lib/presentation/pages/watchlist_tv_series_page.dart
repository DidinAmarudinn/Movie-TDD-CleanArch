import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';

class WatchlistTvSeriesPage extends StatelessWidget {
  const WatchlistTvSeriesPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.requestState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.requestState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.watchlistTvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: data.watchlistTvSeries.length,
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