import 'dart:convert';

import 'package:weather_app_refactor/core/utils/typedefs.dart';
import 'package:weather_app_refactor/src/weather/domain/entities/condition.dart';

class ConditionModel extends Condition {
  const ConditionModel({
    super.text,
    super.code,
    super.icon,
  });

  DataMap toMap() {
    final result = <String, dynamic>{};

    if (text != null) {
      result.addAll({'text': text});
    }
    if (icon != null) {
      result.addAll({'icon': icon});
    }
    if (code != null) {
      result.addAll({'code': code});
    }

    return result;
  }

  factory ConditionModel.fromMap(DataMap map) {
    return ConditionModel(
      text: map['text'],
      icon: map['icon'],
      code: map['code']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConditionModel.fromJson(String source) =>
      ConditionModel.fromMap(json.decode(source));
}
