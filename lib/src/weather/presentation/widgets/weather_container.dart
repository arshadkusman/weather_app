import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_refactor/core/utils/constants.dart';
import 'package:weather_app_refactor/src/weather/presentation/widgets/forecast_card.dart';

class WeatherContainer extends StatelessWidget {
  const WeatherContainer({
    required this.widget,
    required this.iconUrl,
    required this.temperature,
    super.key,
  });
  final Widget widget;
  final String iconUrl;
  final String temperature;
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height - 40.h, // Set a max height
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget,
              appSpace,
              _buildRow1(),
              appSpace,
              ForecastCard(iconUrl: iconUrl, temperature: temperature),
              appSpace,
              _buildRow2(),
              appSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow1() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Today',
            style: TextStyle(color: const Color(0xffFFFFFF), fontSize: 14.sp),
          ),
          Text(
            '7-Day Forecasts',
            style: TextStyle(color: const Color(0xffFFFFFF), fontSize: 14.sp),
          ),
        ],
      );

  Widget _buildRow2() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Other Cities',
            style: TextStyle(color: const Color(0xffFFFFFF), fontSize: 14.sp),
          ),
          Text(
            '+',
            style: TextStyle(color: const Color(0xffFFFFFF), fontSize: 20.sp),
          ),
        ],
      );
}
