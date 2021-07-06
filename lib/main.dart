import 'package:alia_movie/ui/splash/splash_screen.dart';
import 'package:alia_movie/utils/navigation/app_navigator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppNavigator appNavigator = AppNavigator();
    return MaterialApp(
      title: 'Alia Movie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.ROUTE,
      onGenerateRoute: appNavigator.onGenerateRoute,
    );
  }
}
