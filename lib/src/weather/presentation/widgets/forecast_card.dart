import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_refactor/core/common/functions/fx.dart';
import 'package:weather_app_refactor/core/utils/constants.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({
    required this.iconUrl,
    required this.temperature,
    super.key,
  });
  final String iconUrl;
  final String temperature;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 120.h,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timeList.length,
        itemBuilder: (context, index) => _forecastCard(timeList[index]),
      ),
    );
  }

  Widget _forecastCard(String time) {
    return Card(
      elevation: 0,
      color: Colors.white.withOpacity(0.2),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: SingleChildScrollView(
          // Add this
          child: Column(
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              appSpace,
              Image.network(
                serializeUrl(url: iconUrl),
                height: 44.h,
              ),
              Text(
                temperature,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
