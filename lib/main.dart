import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie_list/bloc/movie_list_bloc.dart';
import 'package:core/presentation/bloc/popular_tv_series_bloc/popular_tv_series_bloc.dart';
import 'package:core/presentation/bloc/top_rated_movies_bloc/bloc/top_rated_movies_bloc_bloc.dart';
import 'package:core/presentation/bloc/popular_movies_bloc/bloc/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/top_rated_tv_series_bloc/top_rated_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tv_series_detail_bloc/tv_series_detail_bloc.dart';
import 'package:core/presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/watchlist_tv_series_bloc/watchlist_tv_series_bloc.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/main_screen.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/popular_tv_series_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/top_rated_tv_series_page.dart';
import 'package:core/presentation/bloc/tv_series_list_bloc/tv_series_list_bloc.dart';
import 'package:core/presentation/pages/tv_series_detail_page.dart';
import 'package:core/presentation/pages/tv_series_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/presentation/provider/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie_list_notifier.dart';
import 'package:core/presentation/provider/popular_movies_notifier.dart';
import 'package:core/presentation/provider/popular_tv_series.dart';
import 'package:core/presentation/provider/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:core/presentation/provider/tv_series_detail_notifier.dart';
import 'package:core/presentation/provider/tv_series_list_notifier.dart';
import 'package:core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:core/presentation/widgets/custom_drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/search.dart';
import 'package:core/utils/ssl_pining.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 await HttpSSlPining.init();
  di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
            create: (_) => di.locator<WatchlistTvSeriesNotifier>()),
        BlocProvider(create: (_) => di.locator<SearchBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMovieListBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingMovieListBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMovieListBloc>()),
        BlocProvider(
            create: (_) => di.locator<TopRatedMoviesBlocBloc>()
              ..add(TopRatedMoviesBlocEvent())),
        BlocProvider(
            create: (_) =>
                di.locator<PopularMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<PopularTvSeriesListBloc>()),
        BlocProvider(create: (_) => di.locator<OnAirTvSeriesListBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedTvSeriesListBloc>()),
        BlocProvider(
          create: (_) =>
              di.locator<PopularTvSeriesBloc>()..add(PopularTvSeriesEvent()),
        ),
        BlocProvider(
          create: (_) =>
              di.locator<TopRatedTvSeriesBloc>()..add(TopRatedTvSeriesEvent()),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesDetailBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: Material(
          child: CustomDrawer(
            content: MainScreen(),
          ),
        ),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              final isFromMovie = settings.arguments as bool;
              return CupertinoPageRoute(
                builder: (_) => SearchPage(
                  isFromMovie: isFromMovie,
                ),
              );
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvSeriesPage());
            case PopularTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
