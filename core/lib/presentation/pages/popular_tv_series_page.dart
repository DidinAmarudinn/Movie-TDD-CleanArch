
import 'package:core/presentation/bloc/popular_tv_series_bloc/popular_tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../core.dart';
import '../provider/popular_tv_series.dart';
import '../widgets/tv_series_card_list.dart';


class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';
  const PopularTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() =>
    //     Provider.of<PopularTvSeriesNotifier>(context, listen: false)
    //       ..fetchPopularTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Popular Tv Series",
        ),
      ),
       body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc,PopularTvSeriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.tvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is PopularTvSeriesError){
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }else{
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
