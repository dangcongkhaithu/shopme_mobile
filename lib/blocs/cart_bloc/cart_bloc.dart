import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/blocs/cart_bloc/cart_state.dart';
import 'package:shopme_mobile/data/remote/models/remote/cart/cart.dart';
import 'package:shopme_mobile/data/schemas/request/remote/cart/request_cart.dart';
import 'package:shopme_mobile/data/schemas/response/remote/response_base.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/repositories/remote/cart_repository.dart';

class CartBloc extends BaseBloc with SingleBlocMixin {
  final CartRepository _repository = getIt<CartRepository>();

  void addToCart(String token, RequestCart request) {
    single<ResponseBase>(
      () => _repository.addToCart(token, request),
      onSuccess: (response) => AddToCartSuccessState(response: response),
    );
  }

  void getCart(String token) {
    single<Cart>(
      () => _repository.getCart(token),
      onSuccess: (cart) => GetCartSuccessState(cart: cart),
    );
  }

  void deleteCartItem(int cartItemId, String token) {
    single<ResponseBase>(
      () => _repository.deleteCartItem(cartItemId, token),
      onSuccess: (response) => DeleteCartItemSuccessState(response: response),
    );
  }
}
