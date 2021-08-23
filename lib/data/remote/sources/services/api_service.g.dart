// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://localhost:8081/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Category>> getCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Category>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/child_category/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Category.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Product>> getProducts() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Product>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/product/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Product>> searchProduct(keyWord) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Product>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/product/search/$keyWord',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<ResponseSignUp> signUp(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseSignUp>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/user/signUp',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseSignUp.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseSignIn> signIn(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseSignIn>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/user/signIn',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseSignIn.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserProfile> getUserProfile(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserProfile>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/user/$token',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserProfile.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseBase> updateUserProfile(token, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseBase>(
            Options(method: 'PUT', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/user/update/$token',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseBase.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseBase> addToCart(token, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': token};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseBase>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/cart/add',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseBase.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Cart> getCart(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': token};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<Cart>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/cart/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Cart.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseBase> deleteCartItem(cartItemId, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': token};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseBase>(Options(
                method: 'DELETE', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/cart/delete/$cartItemId',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseBase.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseBase> order(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': token};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseBase>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/order/add',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseBase.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Order>> getAllOrders(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': token};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<Order>>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/order/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Order.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<ResponseBase> updateStatus(token, requestOrder) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': token};
    final _data = <String, dynamic>{};
    _data.addAll(requestOrder.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseBase>(
            Options(method: 'PUT', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/order/update',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseBase.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
