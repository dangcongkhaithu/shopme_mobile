// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_sign_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseSignUp _$ResponseSignUpFromJson(Map<String, dynamic> json) {
  return ResponseSignUp(
    code: json['code'] as int,
    user: User.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseSignUpToJson(ResponseSignUp instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.user,
    };
