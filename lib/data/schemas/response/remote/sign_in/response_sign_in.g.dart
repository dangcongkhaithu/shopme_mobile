// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_sign_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseSignIn _$ResponseSignInFromJson(Map<String, dynamic> json) {
  return ResponseSignIn(
    code: json['code'] as int,
    user: User.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseSignInToJson(ResponseSignIn instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.user,
    };
