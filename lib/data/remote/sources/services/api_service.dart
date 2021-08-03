import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:shopme_mobile/data/remote/models/remote/category/category.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';
import 'package:shopme_mobile/data/schemas/request/remote/sign_in/request_sign_in.dart';
import 'package:shopme_mobile/data/schemas/request/remote/sign_up/request_sign_up.dart';
import 'package:shopme_mobile/data/schemas/response/remote/sign_in/response_sign_in.dart';
import 'package:shopme_mobile/data/schemas/response/remote/sign_up/response_sign_up.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://localhost:3000")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  //Category
  @GET("http://localhost:3000/category")
  Future<List<Category>> getCategories();

  //Product
  @GET("http://localhost:3000/product")
  Future<List<Product>> getProducts();

  //User
  @POST("https://freeapi.code4func.com/api/v1/user/sign-up")
  Future<ResponseSignUp> signUp(@Body() RequestSignUp request);

  @POST("https://freeapi.code4func.com/api/v1/user/sign-in")
  Future<ResponseSignIn> signIn(@Body() RequestSignIn request);


}
