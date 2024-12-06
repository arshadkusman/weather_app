import 'package:equatable/equatable.dart';
import 'package:weather_app_refactor/src/weather/domain/entities/condition.dart';

class WeatherMetrics extends Equatable {
  const WeatherMetrics({
    this.tempC,
    this.isDay,
    this.condition,
    this.windKph,
    this.precipMm,
    this.humidity,
  });
  final double? tempC;
  final int? isDay;
  final Condition? condition;
  final double? windKph;
  final double? precipMm;
  final int? humidity;

  @override
  List<Object?> get props =>
      [tempC, isDay, condition, windKph, humidity, precipMm];
}
