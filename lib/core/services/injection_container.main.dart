part of 'injection_container.dart';

final sl = GetIt.instance;
Future<void> init() async {
  final dio = Dio();
  sl.registerLazySingleton(() => dio);
  await _initWeather();
}

Future<void> _initWeather() async {
  sl
    ..registerFactory(
      () => WeatherBloc(usecase: sl(), defaultWeatherUsecase: sl()),
    )
    ..registerLazySingleton(
      () => WeatherUsecase(sl()),
    )
    ..registerLazySingleton(
      () => DefaultWeatherUsecase(sl()),
    )
    ..registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImplementation(sl()),
    )
    ..registerLazySingleton<WeatherRepositoryDataSource>(
      () => WeatherRepositoryDataSourceImplementation(dio: sl()),
    );
}
