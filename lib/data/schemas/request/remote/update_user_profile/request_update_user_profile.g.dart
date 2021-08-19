// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_update_user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestUpdateUserProfile _$RequestUpdateUserProfileFromJson(
    Map<String, dynamic> json) {
  return RequestUpdateUserProfile(
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
    phone: json['phone'] as String,
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$RequestUpdateUserProfileToJson(
        RequestUpdateUserProfile instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'phone': instance.phone,
      'address': instance.address,
    };
