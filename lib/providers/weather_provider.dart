import 'package:flutter/material.dart';
import 'package:flutter_weather_app/api/api.dart';
import 'package:flutter_weather_app/models/weathermodel.dart';
import 'package:geolocator/geolocator.dart';

class WeatherProvider with ChangeNotifier {
  ApiResponse? _currentLocationResponse; // For current location weather
  ApiResponse? _response; // For searched location weather
  bool _inProgress = false;
  String _message = "Search for the location to get weather data";
  final Map<String, ApiResponse?> _weatherData =
      {}; // Store weather data for each location
      
  // Define the list of default locations here
  final List<String> _locations = ["New York", "London", "Tokyo", "Sydney"];

  ApiResponse? get currentLocationResponse => _currentLocationResponse;
  ApiResponse? get response => _response;
  bool get inProgress => _inProgress;
  String get message => _message;
  Map<String, ApiResponse?> get weatherData => _weatherData;
  List<String> get locations => _locations;

  Future<void> fetchCurrentLocationWeather() async {
    _inProgress = true;
    _message = "Fetching weather for current location...";

    // Use addPostFrameCallback to schedule notifyListeners to be called after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("Location services are disabled.");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permissions are denied.");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permissions are permanently denied.");
      }

      Position position = await Geolocator.getCurrentPosition(
          // ignore: deprecated_member_use
          desiredAccuracy: LocationAccuracy.high);
      String location = "${position.latitude},${position.longitude}";

      // Use a separate variable for current location weather
      _currentLocationResponse = await WeatherApi().getCurrentWeather(location);
      _message = "Weather data for current location";
    } catch (e) {
      _message = "Failed to get weather data: ${e.toString()}";
      _currentLocationResponse = null;
    } finally {
      _inProgress = false;

      // Schedule notifyListeners after the build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  Future<void> fetchWeatherForLocation(String location) async {
    _inProgress = true;
    _message = "Fetching weather data for $location...";

    // Use addPostFrameCallback to schedule notifyListeners to be called after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      // Use _response only for search results
      _response = await WeatherApi().getCurrentWeather(location);
      _message = "Weather data for $location";
    } catch (e) {
      _message = "Failed to get weather data: ${e.toString()}";
      _response = null;
    } finally {
      _inProgress = false;

      // Schedule notifyListeners after the build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  // Fetch weather data for default locations
  Future<void> fetchDefaultLocationsWeather() async {
    _inProgress = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    // Fetch weather data for default locations
    for (String location in _locations) {
      try {
        ApiResponse? defaultLocationResponse =
            await WeatherApi().getCurrentWeather(location);
        _weatherData[location] = defaultLocationResponse;
      } catch (e) {
        _weatherData[location] = null; // Set null if fetch fails
      }
    }

    _inProgress = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    }); // Notify listeners that data has been fetched.
  }
}
