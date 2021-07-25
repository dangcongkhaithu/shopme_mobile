import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String name;
  final String alias;
  final String image;
  final bool enable;

  @JsonKey(name: 'has_children')
  bool hasChildren;

  Category({
    required this.id,
    required this.name,
    required this.alias,
    required this.image,
    required this.enable,
    required this.hasChildren,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
