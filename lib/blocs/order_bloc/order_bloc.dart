import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/blocs/order_bloc/order_state.dart';
import 'package:shopme_mobile/data/remote/models/remote/order/order.dart';
import 'package:shopme_mobile/data/schemas/request/remote/order/request_order.dart';
import 'package:shopme_mobile/data/schemas/response/remote/response_base.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/repositories/remote/order_repository.dart';

class OrderBloc extends BaseBloc with SingleBlocMixin {
  final OrderRepository _repository = getIt<OrderRepository>();

  void addOrder(String token) {
    single<ResponseBase>(
      () => _repository.order(token),
      onSuccess: (response) => AddOrderSuccessState(response: response),
    );
  }

  void getAllOrders(String token) {
    single<List<Order>>(
      () => _repository.getAllOrders(token),
      onSuccess: (orders) => GetAllOrderSuccessState(orders: orders),
    );
  }

  void updateStatus(RequestOrder request, String token) {
    single<ResponseBase>(
      () => _repository.updateStatus(request, token),
      onSuccess: (response) => UpdateOrderSuccessState(response: response),
    );
  }
}
