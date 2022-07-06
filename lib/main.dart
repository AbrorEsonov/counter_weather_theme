import 'package:counter_weather_theme/cubit/counter/counter_cubit.dart';
import 'package:counter_weather_theme/cubit/theme/theme_cubit.dart';
import 'package:counter_weather_theme/cubit/weather/weather_cubit.dart';
import 'package:counter_weather_theme/presentation/pages/home.dart';
import 'package:counter_weather_theme/presentation/widgets/dark_theme.dart';
import 'package:counter_weather_theme/repository/weather_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DarkSample());
  }
}

class DarkSample extends StatefulWidget {
  const DarkSample({Key? key}) : super(key: key);

  @override
  _DarkSampleState createState() => _DarkSampleState();
}

class _DarkSampleState extends State<DarkSample> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final circleOffset = Offset(size.width - 380, size.height - 100);
    return DarkTransition(
      childBuilder: (context, x) => MultiBlocProvider(
        providers: [
          BlocProvider<CounterCubit>(
            create: (context) => CounterCubit(),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(WeatherRepository()),
          ),
        ],
        child: DarkTransition(
          childBuilder: (context, x) => MyHomePage(
            title: 'Weather Counter',
            onIncrement: () {
              setState(() {
                isDark = !isDark;
              });
            },
          ),
          offset: circleOffset,
          isDark: isDark,
        ),
      ),
      offset: circleOffset,
      isDark: isDark,
    );
  }
}
