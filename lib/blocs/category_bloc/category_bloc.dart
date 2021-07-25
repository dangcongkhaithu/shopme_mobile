import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/blocs/category_bloc/category_state.dart';
import 'package:shopme_mobile/data/remote/models/remote/category/category.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/repositories/remote/category_repository.dart';

class CategoryBloc extends BaseBloc with SingleBlocMixin {
  CategoryRepository _repository = getIt<CategoryRepository>();

  void getAllCategories() {
    single<List<Category>>(() => _repository.getAllCategories(),
        onSuccess: (categories) => GetCategorySuccessState(categories: categories));
  }
}
