import 'package:json_annotation/json_annotation.dart';

part 'request_sign_up.g.dart';

@JsonSerializable()
class RequestSignUp {
  final String email;
  final String password;

  RequestSignUp({
    required this.email,
    required this.password,
  });


  factory RequestSignUp.fromJson(Map<String, dynamic> json) => _$RequestSignUpFromJson(json);

  Map<String, dynamic> toJson() => _$RequestSignUpToJson(this);
}
