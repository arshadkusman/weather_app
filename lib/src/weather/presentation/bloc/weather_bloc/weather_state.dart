part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  const WeatherLoaded({required this.weather});
  final WeatherData weather;
  @override
  List<Object> get props => [weather];
}

final class WeatherError extends WeatherState {
   const WeatherError({required this.message});

  final String message;
  @override
  List<String> get props => [message];
}
