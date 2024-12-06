import 'package:dio/dio.dart';
import 'package:weather_app_refactor/core/utils/typedefs.dart';

String? getErrorMessage(DioException error) {
  if (error.response != null) {
    return (error.response!.data as DataMap)['message'] as String?;
  }
  return error.message;
}

String serializeUrl({required String url}) {
  if (url.contains("44x44")) {
    final replacedUrl = url.replaceAll('44x44', '88x88');
    return "https:$replacedUrl";
  } else if (url.contains('64x64')) {
    final replacedUrl = url.replaceAll('64x64', '128x128');
    return "https:$replacedUrl";
  }
  return "https:$url";
}
