import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/blocs/get_user_profile_bloc/get_user_profile_state.dart';
import 'package:shopme_mobile/data/remote/models/remote/user_profile/user_profile.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/repositories/remote/user_repository.dart';

class GetUserProfileBloc extends BaseBloc with SingleBlocMixin {
  final UserRepository _repository = getIt<UserRepository>();

  void getUserProfile(String token) {
    single<UserProfile>(
      () => _repository.getUserprofile(token),
      onSuccess: (userProfile) => GetUserProfileSuccessState(userProfile: userProfile),
    );
  }

}
