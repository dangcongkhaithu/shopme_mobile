import 'package:shopme_mobile/data/remote/models/remote/cart/cart.dart';
import 'package:shopme_mobile/data/remote/sources/datasources/cart_datasource.dart';
import 'package:shopme_mobile/data/schemas/request/remote/cart/request_cart.dart';
import 'package:shopme_mobile/data/schemas/response/remote/response_base.dart';
import 'package:shopme_mobile/di/injection.dart';

abstract class CartRepository {
  Future<ResponseBase> addToCart(String token, RequestCart request);

  Future<Cart> getCart(String token);

  Future<ResponseBase> deleteCartItem(int cartItemId, String token);
}

class CartRepositoryImpl extends CartRepository {
  final CartDatasource _datasource;

  CartRepositoryImpl() : _datasource = getIt<CartDatasource>();

  @override
  Future<ResponseBase> addToCart(String token, RequestCart request) {
    return _datasource.addToCart(token, request);
  }

  @override
  Future<Cart> getCart(String token) {
    return _datasource.getCart(token);
  }

  @override
  Future<ResponseBase> deleteCartItem(int cartItemId, String token) {
    return _datasource.deleteCartItem(cartItemId, token);
  }
}
