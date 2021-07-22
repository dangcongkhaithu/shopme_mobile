// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'] as int,
    name: json['name'] as String,
    alias: json['alias'] as String,
    image: json['image'] as String,
    enable: json['enable'] as bool,
    hasChildren: json['has_children'] as bool,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'alias': instance.alias,
      'image': instance.image,
      'enable': instance.enable,
      'has_children': instance.hasChildren,
    };
