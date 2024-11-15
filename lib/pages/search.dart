import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather_app/models/weathermodel.dart';
import 'package:flutter_weather_app/providers/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_weather_app/providers/weather_provider.dart';
import 'package:flutter_weather_app/pages/home.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
    // Fetch default locations' weather when the screen is loaded
    Provider.of<WeatherProvider>(context, listen: false)
        .fetchDefaultLocationsWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Consumer<WeatherProvider>(
          builder: (context, provider, child) {
            return provider.response?.location?.name != null
                ? Text(
                    provider.response!.location!.name!,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Search for City',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
          },
        ),
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
              if (index == 0) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
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
          return Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Icon(Icons.search),
                                ),
                                hintText: 'Search for the Location',
                                filled: true,
                                fillColor: const Color(0xffFFFFFF),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onSubmitted: (value) {
                                provider.fetchWeatherForLocation(value);
                              },
                            ),
                          ),
                          SizedBox(width: 20.w),
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 40,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      provider.inProgress
                          ? const Center(child: CircularProgressIndicator())
                          : provider.response == null
                              ? Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    for (String location in provider.locations)
                                      _weatherInfoCard(location,
                                          provider.weatherData[location]),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Text(
                                      provider.response?.current?.condition
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
                                        child: provider.response?.current
                                                    ?.condition?.icon !=
                                                null
                                            ? Image.network(
                                                "https:${provider.response?.current?.condition?.icon}"
                                                    .replaceAll(
                                                        "64x64", "128x128"),
                                                scale: 0.7,
                                              )
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      "${provider.response?.current?.tempC?.toString() ?? ""}°",
                                      style: TextStyle(
                                        fontSize: 60.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xffFFFFFF),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _dataAndTitleWidget(
                                            provider.response?.location
                                                    ?.localtime
                                                    ?.split(" ")
                                                    .first ??
                                                "",
                                            ""),
                                        const SizedBox(width: 6),
                                        _dataAndTitleWidget(
                                            provider.response?.location
                                                    ?.localtime
                                                    ?.split(" ")
                                                    .last ??
                                                "",
                                            ""),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
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
                                                  "${provider.response?.current?.precipMm ?? ""} mm",
                                                  'assets/images/percipitation.png'),
                                              _infoColumn(
                                                  "Humidity",
                                                  "${provider.response?.current?.humidity ?? ""}%",
                                                  'assets/images/humidity.png'),
                                              _infoColumn(
                                                  "Wind Speed",
                                                  "${provider.response?.current?.windKph ?? ""} km/h",
                                                  'assets/images/wind.png'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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

  Widget _weatherInfoCard(String location, ApiResponse? response) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Card(
        color: Colors.white.withOpacity(0.3),
        margin: const EdgeInsets.symmetric(vertical: 14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (response != null) ...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location,
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffFFFFFF)),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      response.current?.condition?.text ?? "",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "${response.current?.tempC?.toString() ?? ""}°",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffFFFFFF),
                      ),
                    ),
                  ],
                ),
                Image.network(
                  "https:${response.current?.condition?.icon}"
                      .replaceAll("64x64", "128x128"),
                  scale: 0.7,
                ),
              ],
              if (response == null) ...[
                Text(
                  "Weather data for $location is not available",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _dataAndTitleWidget(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _infoColumn(String title, String value, String imagePath) {
    return Column(
      children: [
        Image.asset(imagePath, height: 40.h, width: 40.w),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(fontSize: 15.sp, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 14.sp, color: Colors.white),
        ),
      ],
    );
  }
}
