

import '../../core.dart';
import '../models/tv_series_table.dart';
import 'db/database_helper.dart';

abstract class TvSeriesLocalDataSource{
  Future<String> insertTvSeriesToWatchlist(TvSeriesTable tvSeries);
  Future<String> removeTvSeriesFromWatchlist(TvSeriesTable tvSeries);
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<List<TvSeriesTable>> getWatchListTvSeries();
}

class TvSeriesLocalDataSourceImpl extends TvSeriesLocalDataSource{
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});
  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async{
    final result = await databaseHelper.getTvSeriesById(id);
    if(result != null){
      return TvSeriesTable.fromMap(result);
    }else{
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchListTvSeries()async {
    final result = await databaseHelper.getTvSeriesWatchlist();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertTvSeriesToWatchlist(TvSeriesTable tvSeries)async {
     try {
      await databaseHelper.insertTvSeriesWatchlist(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvSeriesFromWatchlist(TvSeriesTable tvSeries) async{
     try {
      await databaseHelper.removeTvSerieWatchlist(tvSeries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

}