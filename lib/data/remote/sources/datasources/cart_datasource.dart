import 'package:logger/logger.dart';
import 'package:shopme_mobile/data/remote/models/remote/cart/cart.dart';
import 'package:shopme_mobile/data/remote/sources/services/api_service.dart';
import 'package:shopme_mobile/data/schemas/request/remote/cart/request_cart.dart';
import 'package:shopme_mobile/data/schemas/response/remote/response_base.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:dio/dio.dart';

abstract class CartDatasource {
  Future<ResponseBase> addToCart(String token, RequestCart request);

  Future<Cart> getCart(String token);

  Future<ResponseBase> deleteCartItem(int cartItemId, String token);
}

class CartDatasourceImpl extends CartDatasource {
  final RestClient _client;

  CartDatasourceImpl() : _client = getIt<RestClient>();

  Logger _logger = Logger();

  @override
  Future<ResponseBase> addToCart(String token, RequestCart request) async {
    late ResponseBase responseBase;
    await _client.addToCart(token, request).then((value) => responseBase = value).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
      }
    });

    return responseBase;
  }

  @override
  Future<Cart> getCart(String token) async {
    late Cart cart;
    await _client.getCart(token).then((value) => cart = value).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
      }
    });

    return cart;
  }

  @override
  Future<ResponseBase> deleteCartItem(int cartItemId, String token) async {
    late ResponseBase responseBase;
    await _client.deleteCartItem(cartItemId, token).then((value) => responseBase = value).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
      }
    });

    return responseBase;
  }
}
