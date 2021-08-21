import 'package:json_annotation/json_annotation.dart';
import 'package:shopme_mobile/data/remote/models/remote/product/product.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  final int id;
  final Product product;
  final int quantity;
  final int userId;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.userId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
