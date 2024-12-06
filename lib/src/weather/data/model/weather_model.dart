import 'dart:convert';
import 'package:weather_app_refactor/core/utils/typedefs.dart';
import 'package:weather_app_refactor/src/weather/data/model/location_model.dart';
import 'package:weather_app_refactor/src/weather/data/model/weather_metrics_model.dart';
import 'package:weather_app_refactor/src/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    super.location,
    super.metrics,
  });

  DataMap toMap() {
    final result = <String, dynamic>{};

    if (location != null) {
      result.addAll({
        'location':
            LocationModel(name: location!.name, localTime: location!.localTime)
                .toMap()
      });
    }
    if (metrics != null) {
      result.addAll({
        'current': WeatherMetricsModel(
          condition: metrics!.condition,
          tempC: metrics!.tempC,
          humidity: metrics!.humidity,
          windKph: metrics!.windKph,
          isDay: metrics!.isDay,
          precipMm: metrics!.precipMm,
        ).toMap()
      });
    }

    return result;
  }

  factory WeatherModel.fromMap(DataMap map) {
    return WeatherModel(
      location: map['location'] != null
          ? LocationModel.fromMap(map['location'])
          : null,
      metrics: map['current'] != null
          ? WeatherMetricsModel.fromMap(map['current'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source));
}
