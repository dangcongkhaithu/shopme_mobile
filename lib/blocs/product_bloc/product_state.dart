import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';

abstract class ProductState extends BaseState {}

class GetProductSuccessState extends ProductState {
  final List<Product> products;

  GetProductSuccessState({
    this.products = const [],
  });

  @override
  List<Object?> get props => [products];
}
