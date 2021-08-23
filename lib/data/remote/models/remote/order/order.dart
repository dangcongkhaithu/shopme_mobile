import 'package:json_annotation/json_annotation.dart';
import 'package:shopme_mobile/data/remote/models/remote/order_item/order_item.dart';
import 'package:shopme_mobile/data/remote/models/remote/shipping_info/shipping_info.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int id;
  final ShippingInfo shippingInfo;
  final List<OrderItem> orderItems;
  final String status;
  final double totalPrice;

  Order({
    required this.id,
    required this.shippingInfo,
    required this.orderItems,
    required this.status,
    required this.totalPrice,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
