import 'package:shopme_mobile/data/remote/models/remote/category/category.dart';
import 'package:shopme_mobile/data/remote/sources/datasources/category_datasource.dart';
import 'package:shopme_mobile/di/injection.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategories();
}

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDatasource _categoryDatasource;

  CategoryRepositoryImpl() : _categoryDatasource = getIt<CategoryDatasource>();

  @override
  Future<List<Category>> getAllCategories() {
    return _categoryDatasource.getAllCategories();
  }
}
