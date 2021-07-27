import 'package:moor/moor.dart';
import 'package:shopme_mobile/data/local/database/entities/recent_search_entity.dart';

import '../local_database.dart';
import 'base_dao_mixin.dart';

part 'recent_search_dao.g.dart';

@UseDao(tables: [RecentSearchEntity])
class RecentSearchDao extends DatabaseAccessor<LocalDatabase>
    with _$RecentSearchDaoMixin, BaseDaoMixin<LocalRecentSearch, $RecentSearchEntityTable, RecentSearchEntityCompanion> {
  RecentSearchDao(LocalDatabase attachedDatabase) : super(attachedDatabase);

  @override
  TableInfo<$RecentSearchEntityTable, LocalRecentSearch> get table => recentSearchEntity;

}