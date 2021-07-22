import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:shopme_mobile/data/models/remote/category/category.dart';

part 'api_service.g.dart';

@RestApi(baseUrl:"http://localhost:3000")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/category")
  Future<List<Category>> getCategories();

}
