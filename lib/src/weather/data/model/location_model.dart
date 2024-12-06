import 'dart:convert';

import 'package:weather_app_refactor/core/utils/typedefs.dart';
import 'package:weather_app_refactor/src/weather/domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({
    super.localTime,
    super.name,
  });

  DataMap toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (localTime != null) {
      result.addAll({'localtime': localTime});
    }

    return result;
  }

  factory LocationModel.fromMap(DataMap map) {
    return LocationModel(
      name: map['name'],
      localTime: map['localtime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source));
}
