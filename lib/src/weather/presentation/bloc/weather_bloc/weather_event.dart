part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherEvent extends WeatherEvent {
  const GetWeatherEvent({required this.location});
  final String location;
  @override
  List<String> get props => [location];
}

class GetDefaultWeatherEvent extends WeatherEvent {
  const GetDefaultWeatherEvent();
}
