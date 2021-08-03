import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/blocs/sign_up_bloc/sign_up_state.dart';
import 'package:shopme_mobile/data/schemas/request/remote/sign_up/request_sign_up.dart';
import 'package:shopme_mobile/data/schemas/response/remote/sign_up/response_sign_up.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/repositories/remote/user_repository.dart';

class SignUpBloc extends BaseBloc with SingleBlocMixin {
  final UserRepository _repository = getIt<UserRepository>();

  void signUp(RequestSignUp request) {
    single<ResponseSignUp>(
      () => _repository.signUp(request),
      onSuccess: (response) => SignUpSuccessState(response: response),
    );
  }
}
