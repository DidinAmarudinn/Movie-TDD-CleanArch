import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockMovieDetailState extends Fake implements MovieDetailState {}

class MockMovieDetailEvent extends Fake implements MovieDetailEvent {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;

  setUpAll(() {
    registerFallbackValue(MockMovieDetailState());
    registerFallbackValue(MockMovieDetailEvent());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockMovieDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      "Watchlist button should display add icon when movie not added to watchlist",
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailState.initial()
        .copyWith(
            message: "",
            movieDetail: testMovieDetail,
            movieRecommendationsState: RequestState.Loaded,
            isAddedToWatchlist: false,
            movieRecommendations: <Movie>[],
            movieDetailState: RequestState.Loaded));
    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
  testWidgets(
      "Watchlist button should display checklist icon when movie not added to watchlist",
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailState.initial()
        .copyWith(
            message: "",
            movieDetail: testMovieDetail,
            movieRecommendationsState: RequestState.Loaded,
            isAddedToWatchlist: true,
            movieRecommendations: <Movie>[],
            movieDetailState: RequestState.Loaded));
    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockMovieDetailBloc,
        Stream.value(MovieDetailState.initial().copyWith(
          movieDetail: testMovieDetail,
          movieDetailState: RequestState.Loaded,
          movieRecommendationsState: RequestState.Loaded,
          isAddedToWatchlist: true,
          watchlistMessage: 'Added to Watchlist',
        )));
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailState.initial()
        .copyWith(
            movieDetail: testMovieDetail,
            movieDetailState: RequestState.Loaded,
            movieRecommendationsState: RequestState.Loaded));

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    whenListen(
        mockMovieDetailBloc,
        Stream.value(MovieDetailState.initial().copyWith(
          movieDetail: testMovieDetail,
          movieDetailState: RequestState.Loaded,
          movieRecommendationsState: RequestState.Loaded,
          isAddedToWatchlist: true,
          watchlistMessage: 'Failed',
        )));
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailState.initial()
        .copyWith(
            movieDetail: testMovieDetail,
            movieDetailState: RequestState.Loaded,
            movieRecommendationsState: RequestState.Loaded));

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
