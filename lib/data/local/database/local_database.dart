import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopme_mobile/core/common/constants/app_constant.dart';
import 'package:shopme_mobile/data/local/database/entities/recent_search_entity.dart';
import 'package:path/path.dart' as path;

part 'local_database.g.dart';

@UseMoor(tables: [RecentSearchEntity], daos: [])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, AppConstant.DB_NAME));
    return VmDatabase(file);
  });
}
