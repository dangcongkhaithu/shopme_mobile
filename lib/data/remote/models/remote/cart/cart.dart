import 'package:json_annotation/json_annotation.dart';
import 'package:shopme_mobile/data/remote/models/remote/cart_item/cart_item.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  final List<CartItem> cartItems;
  final double totalCost;

  Cart({
    required this.cartItems,
    required this.totalCost,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

}
