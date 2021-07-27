import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/blocs/recent_search_bloc/recent_search_state.dart';
import 'package:shopme_mobile/data/local/models/recent_search.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/repositories/local/recent_search_repository.dart';

class RecentSearchBloc extends BaseBloc with SingleBlocMixin {
  RecentSearchRepository _repository = getIt<RecentSearchRepository>();

  void getAll() {
    single<List<RecentSearch>>(
      () => _repository.getAll(),
      onSuccess: (recentSearch) => GetRecentSearchSuccessState(listRecentSearch: recentSearch),
    );
  }

  void saveOne(String content) {
    single<bool>(
      () => _repository.saveOne(content),
      onSuccess: (_) => SaveRecentSearchSuccessState(),
    );
  }

  void deleteOne(int id) {
    single<bool>(
      () => _repository.deleteOne(id),
      onSuccess: (_) => DeleteRecentSearchSuccessState(),
    );
  }

  void filter(String content) {
    single<List<RecentSearch>>(
      () => _repository.findWhere(content),
      onSuccess: (recentSearch) => FilterRecentSearchSuccessState(listRecentSearch: recentSearch),
    );
  }
}
