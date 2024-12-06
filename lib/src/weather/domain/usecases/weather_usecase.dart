import 'package:weather_app_refactor/core/usecases/usecases.dart';
import 'package:weather_app_refactor/core/utils/typedefs.dart';
import 'package:weather_app_refactor/src/weather/domain/repository/weather_repo.dart';

class WeatherUsecase extends UsecaseWithParams<WeatherData, String> {
  const WeatherUsecase(this._repo);
  final WeatherRepository _repo;
  @override
  ResultFuture<WeatherData> call(params) => _repo.getWeatherMetrics(params);
}
