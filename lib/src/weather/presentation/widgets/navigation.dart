import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_refactor/src/weather/presentation/pages/home.dart';
import 'package:weather_app_refactor/src/weather/presentation/pages/search.dart';
import 'package:weather_app_refactor/src/weather/presentation/provider/bottom_nav_provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
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
    );
  }
}
