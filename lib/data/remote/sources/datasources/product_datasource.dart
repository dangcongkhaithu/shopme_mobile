import 'package:logger/logger.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';
import 'package:dio/dio.dart';
import 'package:shopme_mobile/data/remote/sources/services/api_service.dart';
import 'package:shopme_mobile/di/injection.dart';

abstract class ProductDatasource {
  Future<List<Product>> getProducts();

  Future<List<Product>> searchProduct(String keyWord);
}

class ProductDatasourceImpl extends ProductDatasource {
  final RestClient _client;

  ProductDatasourceImpl() : _client = getIt<RestClient>();

  Logger _logger = Logger();

  @override
  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    await _client.getProducts().then((value) => products = value).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
      }
    });

    return products;
  }

  @override
  Future<List<Product>> searchProduct(String keyWord) async {
    List<Product> products = [];
    await _client.searchProduct(keyWord).then((value) => products = value).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
      }
    });

    return products;
  }
}
