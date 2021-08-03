import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/data/schemas/response/remote/sign_up/response_sign_up.dart';

class SignUpState extends BaseState {}

class SignUpSuccessState extends SignUpState {
  final ResponseSignUp response;

  SignUpSuccessState({
    required this.response
});

  @override
  List<Object?> get props => [response];
}