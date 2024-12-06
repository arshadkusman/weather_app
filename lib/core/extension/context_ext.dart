import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_refactor/src/weather/presentation/bloc/weather_bloc/weather_bloc.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;
  WeatherBloc get weatherBloc => read<WeatherBloc>();
}
