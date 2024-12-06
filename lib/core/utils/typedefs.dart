import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_refactor/core/errors/failures.dart';
import 'package:weather_app_refactor/src/weather/domain/entities/weather.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef UpdateValueAndLabelCallback = void Function(
  BuildContext context, {
  required DataMap data,
});

typedef DataMap = Map<String, dynamic>;
typedef WeatherData = Map<String, Weather>;

typedef BoolNotifier = ValueNotifier<bool>;

typedef MapString = Map<String, String>;
