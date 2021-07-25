import 'package:get_it/get_it.dart';
import 'package:shopme_mobile/blocs/category_bloc/category_bloc.dart';
import 'package:shopme_mobile/blocs/product_bloc/product_bloc.dart';
import 'package:shopme_mobile/data/remote/sources/datasources/category_datasource.dart';
import 'package:shopme_mobile/data/remote/sources/datasources/product_datasource.dart';
import 'package:shopme_mobile/data/remote/sources/services/api_service.dart';
import 'package:shopme_mobile/repositories/remote/category_repository.dart';
import 'package:shopme_mobile/repositories/remote/product_repository.dart';
import 'package:dio/dio.dart';

GetIt $initGetIt(GetIt getIt) {
  getIt.registerLazySingleton<RestClient>(
    () => RestClient(Dio(BaseOptions(contentType: "application/json"))),
  );

  registerDataSource(getIt);
  registerRepository(getIt);
  registerBloC(getIt);

  return getIt;
}

void registerDataSource(GetIt getIt) {
  getIt.registerLazySingleton<CategoryDatasource>(() => CategoryDatasourceImpl());
  getIt.registerLazySingleton<ProductDatasource>(() => ProductDatasourceImpl());
}

void registerRepository(GetIt getIt) {
  getIt.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl());
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
}

void registerBloC(GetIt getIt) {
  getIt.registerFactory<CategoryBloc>(() => CategoryBloc());
  getIt.registerFactory<ProductBloc>(() => ProductBloc());
}
