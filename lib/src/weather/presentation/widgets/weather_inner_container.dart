import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_refactor/core/common/functions/fx.dart';
import 'package:weather_app_refactor/core/res/media_res.dart';
import 'package:weather_app_refactor/src/weather/domain/entities/location.dart';
import 'package:weather_app_refactor/src/weather/domain/entities/weather_metrics.dart';

class WeatherInnerContainer extends StatelessWidget {
  const WeatherInnerContainer(
      {required this.location, required this.metrics, super.key});
  final WeatherMetrics? metrics;
  final Location? location;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          location?.name ?? "",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xffFFFFFF),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          metrics?.condition?.text ?? "",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xffFFFFFF),
          ),
        ),
        Center(
          child: SizedBox(
            height: 200.h,
            child: metrics?.condition?.icon != null
                ? Image.network(
                    serializeUrl(
                        url: metrics?.condition!.icon ?? MediaRes.placeHolder),
                    scale: 0.7,
                  )
                : Image.network(MediaRes.placeHolder),
          ),
        ),
        Text(
          "${metrics?.tempC?.toString() ?? ""}°",
          style: TextStyle(
            fontSize: 60.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xffFFFFFF),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dataAndTitleWidget(
                location?.localTime?.split(" ").first ?? "", ""),
            _dataAndTitleWidget(location?.localTime?.split(" ").last ?? "", ""),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Card(
            elevation: 0,
            color: Colors.white.withOpacity(0.1),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoColumn(
                    "Precipitation",
                    "${metrics?.precipMm ?? ""} mm",
                    MediaRes.percipitation,
                  ),
                  _infoColumn(
                    "Humidity",
                    "${metrics?.humidity ?? ""}%",
                    MediaRes.humidity,
                  ),
                  _infoColumn(
                    "Wind Speed",
                    "${metrics?.windKph ?? ""} km/h",
                    MediaRes.wind,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dataAndTitleWidget(String data, String? title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            data,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            title!,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoColumn(String title, String data, String iconPath) {
    return Column(
      children: [
        Image.asset(
          iconPath,
          height: 26.h,
        ),
        _dataAndTitleWidget(data, title),
      ],
    );
  }
}
