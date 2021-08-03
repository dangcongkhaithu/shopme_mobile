import 'package:json_annotation/json_annotation.dart';
import 'package:shopme_mobile/data/remote/models/remote/user/user.dart';

part 'response_sign_up.g.dart';

@JsonSerializable()
class ResponseSignUp {
  final int code;

  @JsonKey(name: "data")
  final User user;

  ResponseSignUp({
    required this.code,
    required this.user,
});

  factory ResponseSignUp.fromJson(Map<String, dynamic> json) => _$ResponseSignUpFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSignUpToJson(this);
}