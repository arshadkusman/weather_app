import 'dart:convert';

import 'package:flutter_weather_app/api/constants.dart';
import 'package:flutter_weather_app/models/weathermodel.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<ApiResponse> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        throw Exception("Invalid request. Please check the location input.");
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized. Please check your API key.");
      } else if (response.statusCode == 404) {
        throw Exception("Location not found. Please try another location.");
      } else {
        throw Exception("Failed to load weather. Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load weather: ${e.toString()}");
    }
  }
}
