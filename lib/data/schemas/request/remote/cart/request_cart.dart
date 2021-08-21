
import 'package:json_annotation/json_annotation.dart';

part 'request_cart.g.dart';

@JsonSerializable()
class RequestCart {
  final int productId;
  final int quantity;

  RequestCart({
    required this.productId,
    required this.quantity,
});

  factory RequestCart.fromJson(Map<String, dynamic> json) => _$RequestCartFromJson(json);

  Map<String, dynamic> toJson() => _$RequestCartToJson(this);
}