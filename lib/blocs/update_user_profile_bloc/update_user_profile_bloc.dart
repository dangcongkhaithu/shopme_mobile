import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/blocs/update_user_profile_bloc/update_user_profile_state.dart';
import 'package:shopme_mobile/data/schemas/request/remote/update_user_profile/request_update_user_profile.dart';
import 'package:shopme_mobile/data/schemas/response/remote/response_base.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/repositories/remote/user_repository.dart';

class UpdateUserProfileBloc extends BaseBloc with SingleBlocMixin {
  final UserRepository _repository = getIt<UserRepository>();

  void updateUserProfile(String token, RequestUpdateUserProfile request) {
    single<ResponseBase>(
          () => _repository.updateUserProfile(token, request),
      onSuccess: (response) => UpdateUserProfileSuccessState(response: response),
    );
  }
}