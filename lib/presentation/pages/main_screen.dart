import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/tv_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true, initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, TvSeriesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME, arguments: selectedIndex == 0? true: false);
            },
            icon: Icon(Icons.search),
          )
        ],
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
                  style: kHeading5.copyWith(color: kMikadoYellow.withOpacity(selectedIndex==0?1:0.4)),
                ),
              ),
              SizedBox(
                width: kDefaultPadding/2,
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
                  style:kHeading5.copyWith(color: kMikadoYellow.withOpacity(selectedIndex==1?1:0.4)),
                ),
              ),
            ],
          ),
          Expanded(
              child: PageView(
            controller: pageController,
            children: [HomeMoviePage(), TvSeriesPage()],
          ))
        ],
      ),
    );
  }
}
