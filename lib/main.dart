import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_report/utils/string_constants.dart';
import 'package:weather_report/utils/theme_helper.dart';
import 'package:weather_report/view_models/weather_view_model.dart';
import 'package:weather_report/views/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeatherViewModel>(
        create: (context) => WeatherViewModel(),
        child: MaterialApp(
          title: appName,
          theme: ThemeHelper.lightTheme,
          darkTheme: ThemeHelper.darkTheme,
          home: const MainPage(),
        ));
  }
}
