import 'package:logger/logger.dart';
import 'package:shopme_mobile/data/remote/models/remote/order/order.dart';
import 'package:shopme_mobile/data/remote/sources/services/api_service.dart';
import 'package:shopme_mobile/data/schemas/request/remote/order/request_order.dart';
import 'package:shopme_mobile/data/schemas/response/remote/response_base.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:dio/dio.dart';

abstract class OrderDatasource {
  Future<ResponseBase> order(String token);

  Future<List<Order>> getAllOrders(String token);

  Future<ResponseBase> updateStatus(RequestOrder request, String token);
}

class OrderDatasourceImpl extends OrderDatasource {
  final RestClient _client;

  OrderDatasourceImpl() : _client = getIt<RestClient>();

  Logger _logger = Logger();

  @override
  Future<ResponseBase> order(String token) async {
    late ResponseBase responseBase;
    await _client.order(token).then((value) => responseBase = value).catchError((Object obj) {
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
  Future<List<Order>> getAllOrders(String token) async {
    late List<Order> orders = [];
    await _client.getAllOrders(token).then((value) => orders = value).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
      }
    });

    return orders;
  }

  @override
  Future<ResponseBase> updateStatus(RequestOrder request, String token) async {
    late ResponseBase responseBase;
    await _client.updateStatus(token, request).then((value) => responseBase = value).catchError((Object obj) {
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
