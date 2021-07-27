import 'package:moor/moor.dart';
import 'package:shopme_mobile/data/local/database/local_database.dart';
import 'package:shopme_mobile/data/local/models/recent_search.dart';
import 'package:shopme_mobile/di/injection.dart';

abstract class RecentSearchDatasource {
  Future<List<RecentSearch>> getAll();

  Future<bool> saveOne(String content);

  Future<bool> deleteOne(int id);

  Future<List<RecentSearch>> findWhere(String content);
}

class RecentSearchDatasourceImpl extends RecentSearchDatasource {
  final LocalDatabase _localDatabase;

  RecentSearchDatasourceImpl() : _localDatabase = getIt<LocalDatabase>();

  @override
  Future<bool> deleteOne(int id) async {
    int deleteRow = await _localDatabase.recentSearchDao.deleteWhere(
      RecentSearchEntityCompanion(
        id: Value(id),
      ),
    );
    return deleteRow > 0;
  }

  @override
  Future<List<RecentSearch>> getAll() async {
    List<LocalRecentSearch> localRecentSearch = await _localDatabase.recentSearchDao.all;
    return localRecentSearch.map((e) => RecentSearch.fromLocal(e)).toList();
  }

  @override
  Future<bool> saveOne(String content) async {
    int insertRow = await _localDatabase.recentSearchDao.insertOne(
      RecentSearchEntityCompanion(
        content: Value(content),
      ),
    );

    return insertRow > 0;
  }

  @override
  Future<List<RecentSearch>> findWhere(String content) async {
    List<LocalRecentSearch> localRecentSearch =
        await _localDatabase.recentSearchDao.findWhere((e) => e.content.equals(content));
    return localRecentSearch.map((e) => RecentSearch.fromLocal(e)).toList();
  }
}
