import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_refactor/core/res/media_res.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.2,
            child: Image.asset(
              MediaRes.backgroundImage,
              fit: BoxFit.fill,
              height: 1900.h,
              width: 850.w,
            ),
          ),
        ),
      ],
    );
  }
}
