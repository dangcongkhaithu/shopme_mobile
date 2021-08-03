// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_sign_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestSignUp _$RequestSignUpFromJson(Map<String, dynamic> json) {
  return RequestSignUp(
    fullName: json['fullName'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    password: json['password'] as String,
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$RequestSignUpToJson(RequestSignUp instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'address': instance.address,
    };
