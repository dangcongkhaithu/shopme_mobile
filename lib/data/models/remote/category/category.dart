import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  int id;
  String name;
  String alias;
  String image;
  bool enable;

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
