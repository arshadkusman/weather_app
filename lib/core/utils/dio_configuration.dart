import 'package:dio/dio.dart';
import 'package:weather_app_refactor/core/res/api_routes.dart';
import 'package:weather_app_refactor/core/utils/typedefs.dart';

class DioConfigured {
  DioConfigured(
    this._dio, {
    required this.token,
    DataMap headers = const {},
  }) {
    _dio.options.baseUrl = ApiRoutes.apiRoot;
    _dio.options.headers = {'Authorization': 'Bearer $token'};
    _dio.options.responseType = ResponseType.json;
    _dio.options.headers.addAll(headers);
  }

  DioConfigured.withoutToken(this._dio, {this.token}) {
    _dio.options.baseUrl = ApiRoutes.apiRoot;
    _dio.options.responseType = ResponseType.json;
  }
  DioConfigured.download(
    this._dio, {
    required this.token,
    DataMap headers = const {},
  }) {
    _dio.options.baseUrl = ApiRoutes.apiRoot;
    _dio.options.responseType = ResponseType.bytes;
    _dio.options.headers = {'Authorization': 'Bearer $token'};
    _dio.options.headers.addAll(headers);
  }

  final String? token;
  final Dio _dio;

  Dio get configuredDio => _dio;
}
