import 'package:shopme_mobile/data/local/database/local_database.dart';

class RecentSearch {
  final int id;
  final String content;

  RecentSearch({
    required this.id,
    required this.content,
  });

  factory RecentSearch.fromLocal(LocalRecentSearch entity) {
    return RecentSearch(
      id: entity.id,
      content: entity.content,
    );
  }

  LocalRecentSearch toLocal() {
    return LocalRecentSearch(
      id: this.id,
      content: this.content,
    );
  }

  RecentSearch copyWith({int? id, String? content}) {
    return RecentSearch(
      id: id ?? this.id,
      content: content ?? this.content,
    );
  }
}
