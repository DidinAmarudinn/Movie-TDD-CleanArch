import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/top_rated_movies_bloc/bloc/top_rated_movies_bloc_bloc.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTopRatedMovieBlocState extends Fake
    implements TopRatedMoviesBlocState {}

class MockTopRatedMovieBlocEvent extends Fake
    implements TopRatedMoviesBlocEvent {}

class MockTopRatedMovieBloc
    extends MockBloc<TopRatedMoviesBlocEvent, TopRatedMoviesBlocState>
    implements TopRatedMoviesBlocBloc {}

void main() {
  late MockTopRatedMovieBloc mockTopRatedMovieBloc;

  setUp(() {
    mockTopRatedMovieBloc = MockTopRatedMovieBloc();
  });

  setUpAll(() {
    registerFallbackValue(MockTopRatedMovieBlocEvent());
    registerFallbackValue(MockTopRatedMovieBlocState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBlocBloc>.value(
      value: mockTopRatedMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }
   testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(()=> mockTopRatedMovieBloc.state).thenReturn(TopRatedMoviesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
   when(()=> mockTopRatedMovieBloc.state).thenReturn(TopRateMoviesHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
  when(()=> mockTopRatedMovieBloc.state).thenReturn(const TopRateMoviesError("Error message"));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
