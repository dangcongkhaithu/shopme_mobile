import 'package:json_annotation/json_annotation.dart';

part 'request_sign_up.g.dart';

@JsonSerializable()
class RequestSignUp {
  String fullName;
  String email;
  String phone;
  String password;
  String address;

  RequestSignUp({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
  });


  factory RequestSignUp.fromJson(Map<String, dynamic> json) => _$RequestSignUpFromJson(json);

  Map<String, dynamic> toJson() => _$RequestSignUpToJson(this);
}
