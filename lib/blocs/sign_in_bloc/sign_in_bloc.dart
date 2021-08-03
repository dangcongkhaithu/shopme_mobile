import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/blocs/sign_in_bloc/sign_in_state.dart';
import 'package:shopme_mobile/data/schemas/request/remote/sign_in/request_sign_in.dart';
import 'package:shopme_mobile/data/schemas/response/remote/sign_in/response_sign_in.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:shopme_mobile/repositories/remote/user_repository.dart';

class SignInBloc extends BaseBloc with SingleBlocMixin {
  final UserRepository _repository = getIt<UserRepository>();

  void signIn(RequestSignIn request) {
    single<ResponseSignIn>(
      () => _repository.signIn(request),
      onSuccess: (response) => SignInSuccessState(response: response),
    );
  }
}
