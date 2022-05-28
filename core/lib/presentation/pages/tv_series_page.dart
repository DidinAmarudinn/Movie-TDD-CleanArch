import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/tv_series_list_bloc/tv_series_list_bloc.dart';
import 'package:core/presentation/pages/popular_tv_series_page.dart';
import 'package:core/presentation/pages/top_rated_tv_series_page.dart';
import 'package:core/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core.dart';
import '../../domain/entities/tv_series.dart';
import '../widgets/heading_with_navigator.dart';

class TvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tvSeries';
  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
        BlocProvider.of<PopularTvSeriesListBloc>(context).add(FetchPopularTvSeries());
    BlocProvider.of<TopRatedTvSeriesListBloc>(context)
        .add(FetchTopRatedTvSeries());
    BlocProvider.of<OnAirTvSeriesListBloc>(context).add(FetchOnAirTvSeries());
    });
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.all(8),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'On Air',
              style: kHeading6,
            ),
            BlocBuilder<OnAirTvSeriesListBloc, TvSeriesListState>(builder: (context, state) {
            
              if (state is TvSeriesOnAirLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvSeriesOnAirHasData) {
                return TvSeriesList(state.tvSeries);
              } else if (state is TvSeriesOnAirError) {
                return const Text('Failed');
              }else{
                return const SizedBox();
              }
            }),
             BuildHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
              ),
             BlocBuilder<PopularTvSeriesListBloc, TvSeriesListState>(builder: (context, state) {
            
              if (state is TvSeriesPopularLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvSeriesPopularHasData) {
                return TvSeriesList(state.tvSeries);
              } else if (state is TvSeriesPopularError) {
                return const Text('Failed');
              }else{
                return const SizedBox();
              }
            }),
             BuildHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
              ),
           BlocBuilder<TopRatedTvSeriesListBloc, TvSeriesListState>(builder: (context, state) {
            
              if (state is TvSeriesTopRatedLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvSeriesTopRatedHasData) {
                return TvSeriesList(state.tvSeries);
              } else if (state is TvSeriesTopRatedError) {
                return const Text('Failed');
              }else{
                return const SizedBox();
              }
            }),
           
          ],
        )),
      ),
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  const TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = tvSeries[index];
          return InkWell(
            onTap: (){
               Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: series.id,
                );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  placeholder: (context, url) =>const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) =>const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
