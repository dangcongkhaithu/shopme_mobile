import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String name;
  final String alias;

  @JsonKey(name: 'short_description')
  final String shortDescription;

  @JsonKey(name: 'full_description')
  final String fullDescription;

  @JsonKey(name: 'created_time')
  final String createdTime;

  @JsonKey(name: 'updated_time')
  final String updatedTime;

  final bool enable;

  @JsonKey(name: 'in_stock')
  final bool inStock;

  final double cost;
  final double price;

  @JsonKey(name: 'discount_percent')
  final double discountPercent;

  final double length;
  final double width;
  final double height;
  final double weight;

  @JsonKey(name: 'main_image')
  final String mainImage;

  @JsonKey(name: 'category_id')
  final int categoryId;

  @JsonKey(name: 'brand_id')
  final int brandId;

  Product(
      {required this.id,
      required this.name,
      required this.alias,
      required this.shortDescription,
      required this.fullDescription,
      required this.createdTime,
      required this.updatedTime,
      required this.enable,
      required this.inStock,
      required this.cost,
      required this.price,
      required this.discountPercent,
      required this.length,
      required this.width,
      required this.height,
      required this.weight,
      required this.mainImage,
      required this.categoryId,
      required this.brandId});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
