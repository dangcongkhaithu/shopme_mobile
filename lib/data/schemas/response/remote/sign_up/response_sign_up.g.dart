// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_sign_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseSignUp _$ResponseSignUpFromJson(Map<String, dynamic> json) {
  return ResponseSignUp(
    message: json['message'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$ResponseSignUpToJson(ResponseSignUp instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
