import 'package:weather_app_refactor/core/usecases/usecases.dart';
import 'package:weather_app_refactor/core/utils/typedefs.dart';
import 'package:weather_app_refactor/src/weather/domain/repository/weather_repo.dart';

class DefaultWeatherUsecase extends UsecaseWithoutParams<WeatherData> {
  const DefaultWeatherUsecase(this._repo);

  final WeatherRepository _repo;
  @override
  ResultFuture<WeatherData> call() => _repo.getDefaultWeather();
}
