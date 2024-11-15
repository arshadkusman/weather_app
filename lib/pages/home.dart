import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather_app/providers/bottom_navigation_provider.dart';
import 'package:flutter_weather_app/widgets/default_location.dart';
import 'package:provider/provider.dart';
import 'package:flutter_weather_app/pages/search.dart';
import 'package:flutter_weather_app/providers/weather_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Fetch current locations' weather when the screen is loaded
    Provider.of<WeatherProvider>(context, listen: false)
        .fetchCurrentLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Consumer<WeatherProvider>(
          builder: (context, provider, child) {
            return provider.currentLocationResponse?.location?.name != null
                ? Text(
                    provider.currentLocationResponse!.location!.name!,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : const Text('');
          },
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.grid_view_outlined, color: Color(0xffFFFFFF)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<WeatherProvider>(context, listen: false)
                  .fetchCurrentLocationWeather();
            },
            icon: const Icon(Icons.replay_outlined, color: Color(0xffFFFFFF)),
          ),
        ],
      ),
      backgroundColor: const Color(0xff331972),
      bottomNavigationBar: Consumer<BottomNavigationProvider>(
        builder: (context, bottomNavProvider, child) {
          return BottomNavigationBar(
            iconSize: 26,
            elevation: 0,
            backgroundColor: const Color(0xff331972),
            selectedItemColor: const Color(0xffFFFFFF),
            unselectedItemColor: const Color(0xffFFFFFF).withOpacity(0.6),
            currentIndex: bottomNavProvider.selectedIndex,
            onTap: (index) {
              bottomNavProvider.setSelectedIndex(index);
              if (index == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Search()));
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color(0xffFFFFFF),
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
          );
        },
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          // First show CircularProgressIndicator if loading
          if (provider.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    'assets/images/background.png',
                    fit: BoxFit.fill,
                    height: 1900.h,
                    width: 850.w,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            provider.currentLocationResponse?.current?.condition
                                    ?.text ??
                                "",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffFFFFFF),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              height: 200.h,
                              child: provider.currentLocationResponse?.current
                                          ?.condition?.icon !=
                                      null
                                  ? Image.network(
                                      "https:${provider.currentLocationResponse?.current?.condition?.icon}"
                                          .replaceAll("64x64", "128x128"),
                                      scale: 0.7,
                                    )
                                  : Image.network(
                                      'https://via.placeholder.com/128'),
                            ),
                          ),
                          Text(
                            "${provider.currentLocationResponse?.current?.tempC?.toString() ?? ""}°",
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
                                  provider.currentLocationResponse?.location
                                          ?.localtime
                                          ?.split(" ")
                                          .first ??
                                      "",
                                  ""),
                              _dataAndTitleWidget(
                                  provider.currentLocationResponse?.location
                                          ?.localtime
                                          ?.split(" ")
                                          .last ??
                                      "",
                                  ""),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Card(
                              elevation: 0,
                              color: Colors.white.withOpacity(0.1),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoColumn(
                                        "Precipitation",
                                        "${provider.currentLocationResponse?.current?.precipMm ?? ""} mm",
                                        'assets/images/percipitation.png'),
                                    _infoColumn(
                                        "Humidity",
                                        "${provider.currentLocationResponse?.current?.humidity ?? ""}%",
                                        'assets/images/humidity.png'),
                                    _infoColumn(
                                        "Wind Speed",
                                        "${provider.currentLocationResponse?.current?.windKph ?? ""} km/h",
                                        'assets/images/wind.png'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                                color: const Color(0xffFFFFFF),
                                fontSize: 14.sp),
                          ),
                          Text(
                            '7-Day Forecasts',
                            style: TextStyle(
                                color: const Color(0xffFFFFFF),
                                fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _forecastCard(
                                "10 AM",
                                "https:${provider.currentLocationResponse?.current?.condition?.icon}"
                                    .replaceAll("44x44", "88x88"),
                                "${provider.currentLocationResponse?.current?.tempC?.toString() ?? ""}°"),
                            _forecastCard(
                                "12 PM",
                                "https:${provider.currentLocationResponse?.current?.condition?.icon}"
                                    .replaceAll("44x44", "88x88"),
                                "${provider.currentLocationResponse?.current?.tempC?.toString() ?? ""}°"),
                            _forecastCard(
                                "3 PM",
                                "https:${provider.currentLocationResponse?.current?.condition?.icon}"
                                    .replaceAll("44x44", "88x88"),
                                "${provider.currentLocationResponse?.current?.tempC?.toString() ?? ""}°"),
                            _forecastCard(
                                "5 PM",
                                "https:${provider.currentLocationResponse?.current?.condition?.icon}"
                                    .replaceAll("44x44", "88x88"),
                                "${provider.currentLocationResponse?.current?.tempC?.toString() ?? ""}°"),
                            _forecastCard(
                                "7 PM",
                                "https:${provider.currentLocationResponse?.current?.condition?.icon}"
                                    .replaceAll("44x44", "88x88"),
                                "${provider.currentLocationResponse?.current?.tempC?.toString() ?? ""}°"),
                            _forecastCard(
                                "10 PM",
                                "https:${provider.currentLocationResponse?.current?.condition?.icon}"
                                    .replaceAll("44x44", "88x88"),
                                "${provider.currentLocationResponse?.current?.tempC?.toString() ?? ""}°"),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Other Cities',
                            style: TextStyle(
                                color: const Color(0xffFFFFFF),
                                fontSize: 14.sp),
                          ),
                          Text(
                            '+',
                            style: TextStyle(
                                color: const Color(0xffFFFFFF),
                                fontSize: 20.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DefaultLocationWeatherWidget(), // Other city locations widget
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
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

Widget _forecastCard(String time, String icon, String temparature) {
  return Card(
    elevation: 0,
    color: Colors.white.withOpacity(0.2),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          SizedBox(height: 10.h),
          Image.network(
            icon,
            height: 44.h,
          ),
          SizedBox(height: 10.h),
          Text(
            temparature,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ),
  );
}
