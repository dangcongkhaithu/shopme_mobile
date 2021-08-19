// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
    id: json['id'] as int,
    phone: json['phone'] as String,
    address: json['address'] as String,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'address': instance.address,
      'user': instance.user,
    };
