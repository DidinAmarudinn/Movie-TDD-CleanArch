import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/popular_movies_bloc/bloc/popular_movies_bloc.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockPopularMovieState extends Fake implements PopularMoviesState {}

class MockPopularMovieEvent extends Fake implements PopularMoviesEvent {}

class MockPopularMovieBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

void main() {
  late MockPopularMovieBloc mockPopularMovieBloc;

  setUp(() {
    mockPopularMovieBloc = MockPopularMovieBloc();
  });

  setUpAll(() {
    registerFallbackValue(MockPopularMovieEvent());
    registerFallbackValue(MockPopularMovieState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>.value(
      value: mockPopularMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

 testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(()=> mockPopularMovieBloc.state).thenReturn(PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
   when(()=> mockPopularMovieBloc.state).thenReturn(PopularMoviesHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(()=> mockPopularMovieBloc.state).thenReturn(const PopularMoviesError("Error message"));


    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
