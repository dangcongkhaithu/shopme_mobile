import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:shopme_mobile/data/remote/models/remote/category/category.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://localhost:3000")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  //Category
  @GET("/category")
  Future<List<Category>> getCategories();

  //Product
  @GET("/product")
  Future<List<Product>> getProducts();
}
