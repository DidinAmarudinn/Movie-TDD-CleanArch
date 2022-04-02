
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core.dart';
import '../provider/watchlist_tv_series_notifier.dart';
import '../widgets/tv_series_card_list.dart';

class WatchlistTvSeriesPage extends StatelessWidget {
  const WatchlistTvSeriesPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.requestState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.requestState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.watchlistTvSeries[index];
                  return  TvSeriesCard(tvSeries);
                },
                itemCount: data.watchlistTvSeries.length,
              );
            } else {
              return Center(
                key:const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        
      
    );
  }
}