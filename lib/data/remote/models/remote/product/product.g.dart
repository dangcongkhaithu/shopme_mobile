// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    name: json['name'] as String,
    alias: json['alias'] as String,
    shortDescription: json['short_description'] as String,
    fullDescription: json['full_description'] as String,
    createdTime: json['created_time'] as String,
    updatedTime: json['updated_time'] as String,
    enable: json['enable'] as bool,
    inStock: json['in_stock'] as bool,
    cost: (json['cost'] as num).toDouble(),
    price: (json['price'] as num).toDouble(),
    discountPercent: (json['discount_percent'] as num).toDouble(),
    length: (json['length'] as num).toDouble(),
    width: (json['width'] as num).toDouble(),
    height: (json['height'] as num).toDouble(),
    weight: (json['weight'] as num).toDouble(),
    mainImage: json['main_image'] as String,
    categoryId: json['category_id'] as int,
    brandId: json['brand_id'] as int,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'alias': instance.alias,
      'short_description': instance.shortDescription,
      'full_description': instance.fullDescription,
      'created_time': instance.createdTime,
      'updated_time': instance.updatedTime,
      'enable': instance.enable,
      'in_stock': instance.inStock,
      'cost': instance.cost,
      'price': instance.price,
      'discount_percent': instance.discountPercent,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
      'weight': instance.weight,
      'main_image': instance.mainImage,
      'category_id': instance.categoryId,
      'brand_id': instance.brandId,
    };
