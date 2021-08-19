import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/data/remote/models/remote/user_profile/user_profile.dart';
import 'package:shopme_mobile/data/schemas/response/remote/response_base.dart';

class GetUserProfileState extends BaseState {}

class GetUserProfileSuccessState extends GetUserProfileState {
  final UserProfile userProfile;

  GetUserProfileSuccessState({
    required this.userProfile,
  });

  @override
  List<Object?> get props => [userProfile];
}

