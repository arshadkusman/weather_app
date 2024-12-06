import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_refactor/core/services/injection_container.dart';
import 'package:weather_app_refactor/src/weather/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app_refactor/src/weather/presentation/pages/home.dart';
import 'package:weather_app_refactor/src/weather/presentation/provider/bottom_nav_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (_) => sl<WeatherBloc>(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(412, 892),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          ),
          home: const Home(),
        ),
      );
}
