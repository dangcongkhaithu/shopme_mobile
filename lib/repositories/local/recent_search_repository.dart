import 'package:shopme_mobile/data/local/datasources/recent_search_datasource.dart';
import 'package:shopme_mobile/data/local/models/recent_search.dart';
import 'package:shopme_mobile/di/injection.dart';

abstract class RecentSearchRepository {
  Future<List<RecentSearch>> getAll();

  Future<bool> saveOne(String content);

  Future<bool> deleteOne(int id);

  Future<List<RecentSearch>> findWhere(String content);
}

class RecentSearchRepositoryImpl extends RecentSearchRepository {
  final RecentSearchDatasource _datasource;

  RecentSearchRepositoryImpl() : _datasource = getIt<RecentSearchDatasource>();

  @override
  Future<List<RecentSearch>> getAll() {
    return _datasource.getAll();
  }

  @override
  Future<bool> saveOne(String content) {
    return _datasource.saveOne(content);
  }

  @override
  Future<bool> deleteOne(int id) {
    return _datasource.deleteOne(id);
  }

  @override
  Future<List<RecentSearch>> findWhere(String content) {
    return _datasource.findWhere(content);
  }
}
