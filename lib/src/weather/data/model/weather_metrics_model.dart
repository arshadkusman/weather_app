import 'dart:convert';

import 'package:weather_app_refactor/core/utils/typedefs.dart';
import 'package:weather_app_refactor/src/weather/data/model/condition_model.dart';
import 'package:weather_app_refactor/src/weather/domain/entities/weather_metrics.dart';

class WeatherMetricsModel extends WeatherMetrics {
  const WeatherMetricsModel(
      {super.condition,
      super.humidity,
      super.isDay,
      super.precipMm,
      super.tempC,
      super.windKph});

  DataMap toMap() {
    final result = <String, dynamic>{};

    if (tempC != null) {
      result.addAll({'temp_c': tempC});
    }
    if (isDay != null) {
      result.addAll({'is_day': isDay});
    }
    if (condition != null) {
      result.addAll({
        'condition': ConditionModel(
          text: condition!.text,
          icon: condition!.icon,
          code: condition!.code,
        ).toMap()
      });
    }
    if (windKph != null) {
      result.addAll({'wind_kph': windKph});
    }
    if (precipMm != null) {
      result.addAll({'precip_mm': precipMm});
    }
    if (humidity != null) {
      result.addAll({'humidity': humidity});
    }

    return result;
  }

  factory WeatherMetricsModel.fromMap(DataMap map) {
    return WeatherMetricsModel(
      tempC: map['temp_c']?.toDouble(),
      isDay: map['is_day']?.toInt(),
      condition: map['condition'] != null
          ? ConditionModel.fromMap(map['condition'])
          : null,
      windKph: map['wind_kph']?.toDouble(),
      precipMm: map['precip_mm']?.toDouble(),
      humidity: map['humidity']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherMetricsModel.fromJson(String source) =>
      WeatherMetricsModel.fromMap(json.decode(source));
}
