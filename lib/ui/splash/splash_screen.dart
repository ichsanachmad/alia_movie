import 'package:alia_movie/ui/ui.dart';
import 'package:alia_movie/utils/assets/image_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const ROUTE = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _onNavigate() async {
    await Future.delayed(Duration(milliseconds: 1500));
    Navigator.pushNamed(context, HomeScreen.ROUTE);
  }

  @override
  void initState() {
    super.initState();
    _onNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageUtils.LOGO,
                height: 60,
                width: 250,
              ),
              SizedBox(height: 40),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
