
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:core/presentation/pages/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core.dart';
import '../provider/watchlist_movie_notifier.dart';
import '../provider/watchlist_tv_series_notifier.dart';


class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  int selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true, initialPage: selectedIndex);
    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
          .fetchWatchlistTvSeries();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Watchlist'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  pageController.jumpToPage(0);
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: Text(
                  "Movie",
                  style: kHeading5.copyWith(
                      color: kMikadoYellow
                          .withOpacity(selectedIndex == 0 ? 1 : 0.4)),
                ),
              ),
            const  SizedBox(
                width: kDefaultPadding / 2,
              ),
              TextButton(
                onPressed: () {
                  pageController.jumpToPage(1);
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Text(
                  "Tv Series",
                  style: kHeading5.copyWith(
                      color: kMikadoYellow
                          .withOpacity(selectedIndex == 1 ? 1 : 0.4)),
                ),
              ),
            ],
          ),
          Expanded(
              child: PageView(
            controller: pageController,
            physics:const NeverScrollableScrollPhysics(),
            children:const [WatchlistMoviePage(), WatchlistTvSeriesPage()],
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
