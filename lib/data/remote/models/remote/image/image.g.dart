// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image(
    id: json['id'] as int,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
    };
