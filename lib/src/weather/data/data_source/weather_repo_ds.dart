import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_refactor/core/common/functions/fx.dart';
import 'package:weather_app_refactor/core/errors/exceptions.dart';
import 'package:weather_app_refactor/core/res/api_routes.dart';
import 'package:weather_app_refactor/core/utils/constants.dart';
import 'package:weather_app_refactor/core/utils/dio_configuration.dart';
import 'package:weather_app_refactor/core/utils/typedefs.dart';
import 'package:weather_app_refactor/src/weather/data/model/weather_model.dart';

abstract class WeatherRepositoryDataSource {
  const WeatherRepositoryDataSource();

  Future<WeatherData> getWeatherMetrics(String location);
  Future<WeatherData> getDefaultWeather();
}

class WeatherRepositoryDataSourceImplementation
    implements WeatherRepositoryDataSource {
  const WeatherRepositoryDataSourceImplementation({required Dio dio})
      : _dio = dio;
  final Dio _dio;
  @override
  Future<WeatherData> getWeatherMetrics(String location) async {
    try {
      final dio = DioConfigured.withoutToken(_dio).configuredDio;
      final result = await dio
          .get<DataMap>("${ApiRoutes.apiRoot}?key=$apiKey&q=$location");

      return {location: WeatherModel.fromMap(result.data as DataMap)};
    } on DioException catch (e) {
      debugPrint(e.toString());
      final error = getErrorMessage(e);
      throw ServerException(
        message: error ??
            "Something went wrong at WeatherRepositoryDataSource Implementation",
        statusCode: (e.response?.statusCode ?? 505).toString(),
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<WeatherData> getDefaultWeather() async {
    try {
      final WeatherData map = {};
      final dio = DioConfigured.withoutToken(_dio).configuredDio;
      final futures = <Future>[];

      for (var i = 0; i < locations.length; i++) {
        futures.add(dio
            .get<DataMap>("${ApiRoutes.apiRoot}?key=$apiKey&q=${locations[i]}")
            .then((result) {
          map[locations[i]] = WeatherModel.fromMap(result.data as DataMap);
        }));
      }

      await Future.wait(futures);

      return map;
    } on DioException catch (e) {
      debugPrint(e.toString());
      final error = getErrorMessage(e);
      throw ServerException(
        message: error ??
            "Something went wrong at WeatherRepositoryDataSource Implementation",
        statusCode: (e.response?.statusCode ?? 505).toString(),
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }
}
