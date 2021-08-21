import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:shopme_mobile/data/remote/models/remote/cart/cart.dart';
import 'package:shopme_mobile/data/remote/models/remote/category/category.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';
import 'package:shopme_mobile/data/remote/models/remote/user_profile/user_profile.dart';
import 'package:shopme_mobile/data/schemas/request/remote/cart/request_cart.dart';
import 'package:shopme_mobile/data/schemas/request/remote/sign_in/request_sign_in.dart';
import 'package:shopme_mobile/data/schemas/request/remote/sign_up/request_sign_up.dart';
import 'package:shopme_mobile/data/schemas/request/remote/update_user_profile/request_update_user_profile.dart';
import 'package:shopme_mobile/data/schemas/response/remote/response_base.dart';
import 'package:shopme_mobile/data/schemas/response/remote/sign_in/response_sign_in.dart';
import 'package:shopme_mobile/data/schemas/response/remote/sign_up/response_sign_up.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://localhost:8081/api")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  //Category
  @GET("/child_category/")
  Future<List<Category>> getCategories();

  //Product
  @GET("/product/")
  Future<List<Product>> getProducts();

  //User
  @POST("/user/signUp")
  Future<ResponseSignUp> signUp(@Body() RequestSignUp request);

  @POST("/user/signIn")
  Future<ResponseSignIn> signIn(@Body() RequestSignIn request);

  @GET("/user/{token}")
  Future<UserProfile> getUserProfile(@Path() String token);

  @PUT("/user/update/{token}")
  Future<ResponseBase> updateUserProfile(@Path() String token, @Body() RequestUpdateUserProfile request);

  //Cart
  @POST("/cart/add")
  Future<ResponseBase> addToCart(@Query("token") String token, @Body() RequestCart request);

  @GET("/cart/")
  Future<Cart> getCart(@Query("token") String token);

  @DELETE("/cart/delete/{cartItemId}")
  Future<ResponseBase> deleteCartItem(@Path() int cartItemId, @Query("token") String token);
}
