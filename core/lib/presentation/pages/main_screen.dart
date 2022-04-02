
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/tv_series_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/utils/routest.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

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
          const  UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading:const Icon(Icons.movie),
              title:const Text('Movies'),
              onTap: () {
                 pageController.jumpToPage(0);
                 setState(() {
                  selectedIndex =0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:const Icon(Icons.movie),
              title:const Text('Tv Series'),
              onTap: () { 
                pageController.jumpToPage(1);
                setState(() {
                  selectedIndex =1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:const Icon(Icons.save_alt),
              title:const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading:const Icon(Icons.info_outline),
              title:const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title:const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE, arguments: selectedIndex == 0? true: false);
            },
            icon:const Icon(Icons.search),
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
           const   SizedBox(
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
            physics:const NeverScrollableScrollPhysics(),
            children: [HomeMoviePage(),const TvSeriesPage()],
          ))
        ],
      ),
    );
  }
}
