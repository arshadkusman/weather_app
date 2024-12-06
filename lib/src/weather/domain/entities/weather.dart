import 'package:equatable/equatable.dart';
import 'package:weather_app_refactor/src/weather/domain/entities/location.dart';
import 'package:weather_app_refactor/src/weather/domain/entities/weather_metrics.dart';

class Weather extends Equatable {
  const Weather({this.location, this.metrics});
  final Location? location;
  final WeatherMetrics? metrics;

  @override
  List<Object?> get props => [location, metrics];
}
