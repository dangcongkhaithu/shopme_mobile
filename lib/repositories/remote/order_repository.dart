import 'package:shopme_mobile/data/remote/models/remote/order/order.dart';
import 'package:shopme_mobile/data/remote/sources/datasources/order_datasource.dart';
import 'package:shopme_mobile/data/schemas/request/remote/order/request_order.dart';
import 'package:shopme_mobile/data/schemas/response/remote/response_base.dart';
import 'package:shopme_mobile/di/injection.dart';

abstract class OrderRepository {
  Future<ResponseBase> order(String token);

  Future<List<Order>> getAllOrders(String token);

  Future<ResponseBase> updateStatus(RequestOrder request, String token);
}

class OrderRepositoryImpl extends OrderRepository {
  final OrderDatasource _datasource;

  OrderRepositoryImpl() : _datasource = getIt<OrderDatasource>();

  @override
  Future<ResponseBase> order(String token) {
    return _datasource.order(token);
  }

  @override
  Future<List<Order>> getAllOrders(String token) {
    return _datasource.getAllOrders(token);
  }

  @override
  Future<ResponseBase> updateStatus(RequestOrder request, String token) {
    return _datasource.updateStatus(request, token);
  }

}
