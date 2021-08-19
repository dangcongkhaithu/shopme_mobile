import 'package:json_annotation/json_annotation.dart';

part 'request_update_user_profile.g.dart';

@JsonSerializable()
class RequestUpdateUserProfile {
  final String firstname;
  final String lastname;
  final String phone;
  final String address;

  RequestUpdateUserProfile({
   required this.firstname,
   required this.lastname,
   required this.phone,
   required this.address
});

  factory RequestUpdateUserProfile.fromJson(Map<String, dynamic> json) => _$RequestUpdateUserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$RequestUpdateUserProfileToJson(this);
}