// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_sign_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestSignUp _$RequestSignUpFromJson(Map<String, dynamic> json) {
  return RequestSignUp(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$RequestSignUpToJson(RequestSignUp instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
