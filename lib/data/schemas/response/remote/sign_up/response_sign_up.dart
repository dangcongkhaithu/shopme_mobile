import 'package:json_annotation/json_annotation.dart';
import 'package:shopme_mobile/data/remote/models/remote/user/user.dart';

part 'response_sign_up.g.dart';

@JsonSerializable()
class ResponseSignUp {
  final String message;
  final String status;


  ResponseSignUp({
    required this.message,
    required this.status,
});

  factory ResponseSignUp.fromJson(Map<String, dynamic> json) => _$ResponseSignUpFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSignUpToJson(this);
}