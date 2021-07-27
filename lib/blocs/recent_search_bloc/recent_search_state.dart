import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/data/local/models/recent_search.dart';

abstract class RecentSearchState extends BaseState {}

class GetRecentSearchSuccessState extends RecentSearchState {
  final List<RecentSearch> listRecentSearch;

  GetRecentSearchSuccessState({
    this.listRecentSearch = const [],
  });

  @override
  List<Object?> get props => [listRecentSearch];
}

class SaveRecentSearchSuccessState extends RecentSearchState {}

class DeleteRecentSearchSuccessState extends RecentSearchState {}

class FilterRecentSearchSuccessState extends RecentSearchState {
  final List<RecentSearch> listRecentSearch;

  FilterRecentSearchSuccessState({
    this.listRecentSearch = const [],
  });

  @override
  List<Object?> get props => [listRecentSearch];
}
