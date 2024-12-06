import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app_refactor/core/utils/typedefs.dart';
import 'package:weather_app_refactor/src/weather/domain/usecases/default_weather_usecase.dart';
import 'package:weather_app_refactor/src/weather/domain/usecases/weather_usecase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(
      {required WeatherUsecase usecase,
      required DefaultWeatherUsecase defaultWeatherUsecase})
      : _usecase = usecase,
        _defaultWeatherUsecase = defaultWeatherUsecase,
        super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {
      emit(WeatherLoading());
    });
    on<GetWeatherEvent>(_onGetWeatherEventHandler);
    on<GetDefaultWeatherEvent>(_onGetDefaultWeatherEventHandler);
  }

  Future<void> _onGetWeatherEventHandler(
    GetWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    final result = await _usecase(event.location);
    result.fold(
      (failed) => emit(WeatherError(message: failed.message)),
      (weather) => emit(WeatherLoaded(weather: weather)),
    );
  }

  Future<void> _onGetDefaultWeatherEventHandler(
    GetDefaultWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    final result = await _defaultWeatherUsecase();
    result.fold(
      (failed) => emit(WeatherError(message: failed.message)),
      (weather) => emit(WeatherLoaded(weather: weather)),
    );
  }

  final WeatherUsecase _usecase;
  final DefaultWeatherUsecase _defaultWeatherUsecase;
}
