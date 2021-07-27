import 'package:logger/logger.dart';
import 'package:shopme_mobile/data/remote/models/remote/category/category.dart';
import 'package:dio/dio.dart';
import 'package:shopme_mobile/data/remote/sources/services/api_service.dart';
import 'package:shopme_mobile/di/injection.dart';

abstract class CategoryDatasource {
  Future<List<Category>> getAllCategories();
}

class CategoryDatasourceImpl extends CategoryDatasource {
  final RestClient _client;

  CategoryDatasourceImpl() : _client = getIt<RestClient>();

  Logger _logger = Logger();

  @override
  Future<List<Category>> getAllCategories() async {
    List<Category> categories = [];
    await _client.getCategories().then((value) => categories = value).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
      }
    });

    return categories;
  }
}
