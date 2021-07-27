// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class LocalRecentSearch extends DataClass
    implements Insertable<LocalRecentSearch> {
  final int id;
  final String content;
  LocalRecentSearch({required this.id, required this.content});
  factory LocalRecentSearch.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalRecentSearch(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    return map;
  }

  RecentSearchEntityCompanion toCompanion(bool nullToAbsent) {
    return RecentSearchEntityCompanion(
      id: Value(id),
      content: Value(content),
    );
  }

  factory LocalRecentSearch.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalRecentSearch(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
    };
  }

  LocalRecentSearch copyWith({int? id, String? content}) => LocalRecentSearch(
        id: id ?? this.id,
        content: content ?? this.content,
      );
  @override
  String toString() {
    return (StringBuffer('LocalRecentSearch(')
          ..write('id: $id, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, content.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalRecentSearch &&
          other.id == this.id &&
          other.content == this.content);
}

class RecentSearchEntityCompanion extends UpdateCompanion<LocalRecentSearch> {
  final Value<int> id;
  final Value<String> content;
  const RecentSearchEntityCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
  });
  RecentSearchEntityCompanion.insert({
    this.id = const Value.absent(),
    required String content,
  }) : content = Value(content);
  static Insertable<LocalRecentSearch> custom({
    Expression<int>? id,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
    });
  }

  RecentSearchEntityCompanion copyWith(
      {Value<int>? id, Value<String>? content}) {
    return RecentSearchEntityCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentSearchEntityCompanion(')
          ..write('id: $id, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $RecentSearchEntityTable extends RecentSearchEntity
    with TableInfo<$RecentSearchEntityTable, LocalRecentSearch> {
  final GeneratedDatabase _db;
  final String? _alias;
  $RecentSearchEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, content];
  @override
  String get aliasedName => _alias ?? 'RecentSearchDB';
  @override
  String get actualTableName => 'RecentSearchDB';
  @override
  VerificationContext validateIntegrity(Insertable<LocalRecentSearch> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalRecentSearch map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalRecentSearch.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RecentSearchEntityTable createAlias(String alias) {
    return $RecentSearchEntityTable(_db, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $RecentSearchEntityTable recentSearchEntity =
      $RecentSearchEntityTable(this);
  late final RecentSearchDao recentSearchDao =
      RecentSearchDao(this as LocalDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [recentSearchEntity];
}
