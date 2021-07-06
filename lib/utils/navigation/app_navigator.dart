import 'package:alia_movie/ui/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    WidgetBuilder _builder;

    switch (settings.name) {
      case HomeScreen.ROUTE:
        _builder = (context) => HomeScreen();
        break;
      case SplashScreen.ROUTE:
        _builder = (context) => SplashScreen();
        break;
      default:
        throw 'Illegal Routes ${settings.name}';
    }
    return MaterialPageRoute(builder: _builder, settings: settings);
  }
}
