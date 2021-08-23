import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/data/remote/models/remote/order/order.dart';
import 'package:shopme_mobile/data/schemas/response/remote/response_base.dart';

class OrderState extends BaseState {}

class AddOrderSuccessState extends OrderState {
  final ResponseBase response;

  AddOrderSuccessState({
    required this.response,
  });

  @override
  List<Object?> get props => [response];
}

class GetAllOrderSuccessState extends OrderState {
  final List<Order> orders;

  GetAllOrderSuccessState({
    required this.orders,
  });

  @override
  List<Object?> get props => [orders];
}

class UpdateOrderSuccessState extends OrderState {
  final ResponseBase response;

  UpdateOrderSuccessState({
    required this.response,
  });

  @override
  List<Object?> get props => [response];
}
