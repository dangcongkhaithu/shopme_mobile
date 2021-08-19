import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/data/remote/models/remote/user_profile/user_profile.dart';
import 'package:shopme_mobile/data/schemas/response/remote/sign_in/response_sign_in.dart';

class SignInState extends BaseState {}

class SignInSuccessState extends BaseState {
  final ResponseSignIn response;

  SignInSuccessState({
    required this.response,
  });

  @override
  List<Object?> get props => [response];
}
