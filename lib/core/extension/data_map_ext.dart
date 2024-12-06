import 'dart:convert';

import 'package:weather_app_refactor/core/utils/typedefs.dart';

extension DataMapExtension on DataMap {
  String toJson() {
    return const JsonEncoder().convert(this);
  }
}
