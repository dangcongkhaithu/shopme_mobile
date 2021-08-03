import 'package:shopme_mobile/data/remote/sources/datasources/user_datasource.dart';
import 'package:shopme_mobile/data/schemas/request/remote/sign_in/request_sign_in.dart';
import 'package:shopme_mobile/data/schemas/request/remote/sign_up/request_sign_up.dart';
import 'package:shopme_mobile/data/schemas/response/remote/sign_in/response_sign_in.dart';
import 'package:shopme_mobile/data/schemas/response/remote/sign_up/response_sign_up.dart';
import 'package:shopme_mobile/di/injection.dart';

abstract class UserRepository {
  Future<ResponseSignUp> signUp(RequestSignUp request);

  Future<ResponseSignIn> signIn(RequestSignIn request);
}

class UserRepositoryImpl extends UserRepository {
  final UserDatasource _datasource;

  UserRepositoryImpl() : _datasource = getIt<UserDatasource>();

  @override
  Future<ResponseSignUp> signUp(RequestSignUp request) {
    return _datasource.signUp(request);
  }

  @override
  Future<ResponseSignIn> signIn(RequestSignIn request) {
    return _datasource.signIn(request);
  }
}
