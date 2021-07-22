import 'package:logger/logger.dart';
import 'package:shopme_mobile/data/models/remote/category/category.dart';
import 'package:shopme_mobile/data/sources/remote/services/api_service.dart';
import 'package:dio/dio.dart';

abstract class CategoryDatasource {
  Future<List<Category>> getAllCategories();
}

class CategoryDatasourceImpl extends CategoryDatasource {
  final _client = RestClient(Dio(BaseOptions(contentType: "application/json")));
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
