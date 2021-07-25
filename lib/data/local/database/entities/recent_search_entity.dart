import 'package:moor/moor.dart';

@DataClassName("LocalRecentSearch")
class RecentSearchEntity extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();

  TextColumn get content => text().named('content')();

  @override
  String get tableName => "RecentSearchDB";
}