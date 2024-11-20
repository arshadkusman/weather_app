import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather_app/models/weathermodel.dart';
import 'package:flutter_weather_app/providers/weather_provider.dart';
import 'package:provider/provider.dart';

class DefaultLocationWeatherWidget extends StatelessWidget {
  const DefaultLocationWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);

    return provider.inProgress
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (String location in provider.locations)
                  _locationCard(location, provider.weatherData[location]),
              ],
            ),
          );
  }

  Widget _locationCard(String location, ApiResponse? response) {
    return Card(
      elevation: 0,
      color: Colors.white.withOpacity(0.2),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (response != null) ...[
              Image.network(
                "https:${response.current?.condition?.icon}"
                    .replaceAll("44x44", "88x88"),
              ),
              SizedBox(width: 10.w),
              Column(
                children: [
                  Text(
                    location,
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    response.current?.condition?.text ?? "",
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(width: 20.w),
              Text(
                "${response.current?.tempC?.toString() ?? ""}°",
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              ),
            ] else
              Text(
                "No data for $location",
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
