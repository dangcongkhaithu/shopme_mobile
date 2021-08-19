import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/data/schemas/response/remote/response_base.dart';

class UpdateUserProfileState extends BaseState {}

class UpdateUserProfileSuccessState extends UpdateUserProfileState {
  final ResponseBase response;

  UpdateUserProfileSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}