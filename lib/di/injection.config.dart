import 'package:get_it/get_it.dart';
import 'package:shopme_mobile/blocs/cart_bloc/cart_bloc.dart';
import 'package:shopme_mobile/blocs/category_bloc/category_bloc.dart';
import 'package:shopme_mobile/blocs/get_user_profile_bloc/get_user_profile_bloc.dart';
import 'package:shopme_mobile/blocs/product_bloc/product_bloc.dart';
import 'package:shopme_mobile/blocs/recent_search_bloc/recent_search_bloc.dart';
import 'package:shopme_mobile/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:shopme_mobile/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:shopme_mobile/blocs/update_user_profile_bloc/update_user_profile_bloc.dart';
import 'package:shopme_mobile/data/local/database/local_database.dart';
import 'package:shopme_mobile/data/local/datasources/recent_search_datasource.dart';
import 'package:shopme_mobile/data/local/shared_preferences/shared_pref.dart';
import 'package:shopme_mobile/data/remote/sources/datasources/cart_datasource.dart';
import 'package:shopme_mobile/data/remote/sources/datasources/category_datasource.dart';
import 'package:shopme_mobile/data/remote/sources/datasources/product_datasource.dart';
import 'package:shopme_mobile/data/remote/sources/datasources/user_datasource.dart';
import 'package:shopme_mobile/data/remote/sources/services/api_service.dart';
import 'package:shopme_mobile/repositories/local/recent_search_repository.dart';
import 'package:shopme_mobile/repositories/remote/cart_repository.dart';
import 'package:shopme_mobile/repositories/remote/category_repository.dart';
import 'package:shopme_mobile/repositories/remote/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:shopme_mobile/repositories/remote/user_repository.dart';

GetIt $initGetIt(GetIt getIt) {
  getIt.registerSingleton<RestClient>(RestClient(Dio(BaseOptions(contentType: "application/json"))));
  getIt.registerSingleton(LocalDatabase());
  getIt.registerSingleton(SharedPref());

  registerDataSource(getIt);
  registerRepository(getIt);
  registerBloC(getIt);

  return getIt;
}

void registerDataSource(GetIt getIt) {
  getIt.registerLazySingleton<CategoryDatasource>(() => CategoryDatasourceImpl());
  getIt.registerLazySingleton<ProductDatasource>(() => ProductDatasourceImpl());
  getIt.registerLazySingleton<RecentSearchDatasource>(() => RecentSearchDatasourceImpl());
  getIt.registerLazySingleton<UserDatasource>(() => UserDatasourceImpl());
  getIt.registerLazySingleton<CartDatasource>(() => CartDatasourceImpl());
}

void registerRepository(GetIt getIt) {
  getIt.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl());
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
  getIt.registerLazySingleton<RecentSearchRepository>(() => RecentSearchRepositoryImpl());
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  getIt.registerLazySingleton<CartRepository>(() => CartRepositoryImpl());
}

void registerBloC(GetIt getIt) {
  getIt.registerFactory<CategoryBloc>(() => CategoryBloc());
  getIt.registerFactory<ProductBloc>(() => ProductBloc());
  getIt.registerFactory<RecentSearchBloc>(() => RecentSearchBloc());
  getIt.registerFactory<SignUpBloc>(() => SignUpBloc());
  getIt.registerFactory<SignInBloc>(() => SignInBloc());
  getIt.registerFactory<GetUserProfileBloc>(() => GetUserProfileBloc());
  getIt.registerFactory<UpdateUserProfileBloc>(() => UpdateUserProfileBloc());
  getIt.registerFactory<CartBloc>(() => CartBloc());
}
