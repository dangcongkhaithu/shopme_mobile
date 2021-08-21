// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestCart _$RequestCartFromJson(Map<String, dynamic> json) {
  return RequestCart(
    productId: json['productId'] as int,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$RequestCartToJson(RequestCart instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
