import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie);
  Future<String> removeWatchlist(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedNowPlayingMovies();
  Future<void> cachePopularMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedPopularMovies();
  Future<void> cacheTopRatedMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedTopRatedMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCache('now playing');
    await databaseHelper.insertCacheTransaction(movies, 'now playing');
  }

  @override
  Future<List<MovieTable>> getCachedNowPlayingMovies() async {
    final result = await databaseHelper.getCacheMovies('now playing');
    if (result.length > 0) {
      return result.map((movie) => MovieTable.fromMap(movie)).toList();
    } else {
      throw CacheException("Can't get the data :( ");
    }
  }

  @override
  Future<void> cachePopularMovies(List<MovieTable> movies)async {
    await databaseHelper.clearCache('popular');
    await databaseHelper.insertCacheTransaction(movies, 'popular');
  }

  @override
  Future<List<MovieTable>> getCachedPopularMovies()async {
    final result = await databaseHelper.getCacheMovies('popular');
    if(result.length > 0){
      
    return result.map((movie) => MovieTable.fromMap(movie)).toList();
    }else{
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheTopRatedMovies(List<MovieTable> movies) async{
    await databaseHelper.clearCache('top rated');
    await databaseHelper.insertCacheTransaction(movies, 'top rated');
  }

  @override
  Future<List<MovieTable>> getCachedTopRatedMovies() async{
    final result = await databaseHelper.getCacheMovies('top rated');
    if(result.length > 0){
      return result.map((movie) => MovieTable.fromMap(movie)).toList();
    }else{
      throw CacheException("Can't get the data :(");
    }
  }
}
