import 'package:get_it/get_it.dart';
import 'package:shopme_mobile/blocs/category_bloc/category_bloc.dart';
import 'package:shopme_mobile/data/sources/remote/datasources/category_datasource.dart';
import 'package:shopme_mobile/repositories/remote/category_repository.dart';

GetIt $initGetIt(GetIt getIt) {
  registerDataSource(getIt);
  registerRepository(getIt);
  registerBloC(getIt);

  return getIt;
}

void registerDataSource(GetIt getIt) {
  getIt.registerLazySingleton<CategoryDatasource>(
    () => CategoryDatasourceImpl(),
  );
}

void registerRepository(GetIt getIt) {
  getIt.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl());
}

void registerBloC(GetIt getIt) {
  getIt.registerFactory<CategoryBloc>(() => CategoryBloc());
}
