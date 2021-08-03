import 'package:logger/logger.dart';
import 'package:shopme_mobile/data/remote/sources/services/api_service.dart';
import 'package:shopme_mobile/data/schemas/request/remote/sign_in/request_sign_in.dart';
import 'package:shopme_mobile/data/schemas/request/remote/sign_up/request_sign_up.dart';
import 'package:shopme_mobile/data/schemas/response/remote/sign_in/response_sign_in.dart';
import 'package:shopme_mobile/data/schemas/response/remote/sign_up/response_sign_up.dart';
import 'package:shopme_mobile/di/injection.dart';
import 'package:dio/dio.dart';

abstract class UserDatasource {
  Future<ResponseSignUp> signUp(RequestSignUp request);

  Future<ResponseSignIn> signIn(RequestSignIn request);
}

class UserDatasourceImpl extends UserDatasource {
  final RestClient _client;

  UserDatasourceImpl() : _client = getIt<RestClient>();

  Logger _logger = Logger();

  @override
  Future<ResponseSignUp> signUp(RequestSignUp request) async {
    late ResponseSignUp response;
    await _client.signUp(request).then((value) {
      response = value;
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
      }
    });

    return response;
  }

  @override
  Future<ResponseSignIn> signIn(RequestSignIn request) async {
    late ResponseSignIn response;
    await _client.signIn(request).then((value) {
      response = value;
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
      }
    });

    return response;
  }
}
