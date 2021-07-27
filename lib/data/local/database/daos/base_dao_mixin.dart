import 'package:moor/moor.dart';

import '../local_database.dart';

typedef Expression<bool> FilterFunction(var e);

mixin BaseDaoMixin<D extends DataClass, T extends Table, UC extends UpdateCompanion<D>>
    on DatabaseAccessor<LocalDatabase> {
  TableInfo<T, D> get table;

  Future<List<D>> get all => select(table).get();

  Future<int> insertOne(UC data) async {
    return into(table).insertOnConflictUpdate(data);
  }

  Future<int> deleteWhere(UC data) async {
    return delete(table).delete(data);
  }

  Future<List<D>> findWhere(Expression<bool> Function(T e) filter) {
    return (select(table)..where(filter)).get();
  }
}
