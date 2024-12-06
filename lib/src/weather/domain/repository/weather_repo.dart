import 'package:weather_app_refactor/core/utils/typedefs.dart';

abstract class WeatherRepository {
  const WeatherRepository();

  ResultFuture<WeatherData> getWeatherMetrics(String location);
  ResultFuture<WeatherData> getDefaultWeather();
  
}
