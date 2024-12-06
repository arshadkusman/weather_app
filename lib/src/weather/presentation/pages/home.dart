import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app_refactor/core/extension/context_ext.dart';
import 'package:weather_app_refactor/core/res/media_res.dart';
import 'package:weather_app_refactor/src/weather/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app_refactor/src/weather/presentation/widgets/custom_app_bar.dart';
import 'package:weather_app_refactor/src/weather/presentation/widgets/navigation.dart';
import 'package:weather_app_refactor/src/weather/presentation/widgets/weather_container.dart';
import 'package:weather_app_refactor/src/weather/presentation/widgets/weather_inner_container.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(
          title: "Weather",
        ),
        backgroundColor: const Color(0xff331972),
        bottomNavigationBar: const BottomNavBar(),
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              context.weatherBloc.add(const GetDefaultWeatherEvent());
            }
            if (state is WeatherLoading) {
              return Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: const Text('Loading...', style: TextStyle(fontSize: 24)),
              );
            }

            if (state is WeatherError) {
              return const Center(
                  child:
                      Text("An error occurred while fetching weather data."));
            }

            if (state is WeatherLoaded) {
              return Column(
                children: [
                  // const Text(
                  //   "Weather Data",
                  //   style: TextStyle(fontSize: 24, color: Colors.white),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.weather.length,
                      itemBuilder: (context, index) {
                        final key = state.weather.keys.elementAt(index);
                        if (state.weather[key] == null) {
                          return const SizedBox.shrink();
                        }
                        final weatherData = state.weather[key];

                        return WeatherContainer(
                          widget: WeatherInnerContainer(
                            location: weatherData?.location,
                            metrics: weatherData?.metrics,
                          ),
                          iconUrl: weatherData?.metrics?.condition?.icon ??
                              MediaRes.placeHolder,
                          temperature:
                              weatherData?.metrics?.tempC.toString() ?? "0.0",
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink(); // Default case for unhandled states
          },
        ));
  }
}
