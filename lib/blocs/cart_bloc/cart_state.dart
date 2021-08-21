import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/data/remote/models/remote/cart/cart.dart';
import 'package:shopme_mobile/data/schemas/response/remote/response_base.dart';

class CartState extends BaseState {}

class AddToCartSuccessState extends CartState {
  final ResponseBase response;

  AddToCartSuccessState({
    required this.response,
  });

  @override
  List<Object?> get props => [response];
}

class GetCartSuccessState extends CartState {
  final Cart cart;

  GetCartSuccessState({
    required this.cart,
  });

  @override
  List<Object?> get props => [cart];
}

class DeleteCartItemSuccessState extends CartState {
  final ResponseBase response;

  DeleteCartItemSuccessState({
    required this.response,
  });

  @override
  List<Object?> get props => [response];
}
