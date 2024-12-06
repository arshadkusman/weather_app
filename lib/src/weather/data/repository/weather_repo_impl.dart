import 'package:dartz/dartz.dart';
import 'package:weather_app_refactor/core/errors/exceptions.dart';
import 'package:weather_app_refactor/core/errors/failures.dart';
import 'package:weather_app_refactor/core/utils/typedefs.dart';
import 'package:weather_app_refactor/src/weather/domain/repository/weather_repo.dart';
import 'package:weather_app_refactor/src/weather/data/data_source/weather_repo_ds.dart';

class WeatherRepositoryImplementation implements WeatherRepository {
  const WeatherRepositoryImplementation(this._dataSource);
  final WeatherRepositoryDataSource _dataSource;

  @override
  ResultFuture<WeatherData> getWeatherMetrics(String location) async {
    try {
      final result = await _dataSource.getWeatherMetrics(location);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<WeatherData> getDefaultWeather() async {
    try {
      final result = await _dataSource.getDefaultWeather();
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }
}
