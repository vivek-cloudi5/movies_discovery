import 'package:flutter/material.dart';
import 'package:movies_discovery/res/index.dart';
import 'package:movies_discovery/ui/movie_list.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

import '../common_config.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) => setState(() {
      isLoaded = true;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SplashScreenView(
        navigateWhere: isLoaded,
        navigateRoute: const MyHome(),
        backgroundColor: Colors.transparent,
        linearGradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3366FF),
              Color(0xFF00CCFF),
            ],
            stops: [0.0, 0.0],
            tileMode: TileMode.repeated),
        text: WavyAnimatedText(
          "Movie Discovery",
          speed: const Duration(milliseconds: 200),
          textStyle: GoogleFonts.lato(
            color: Colors.redAccent,
            fontSize: 55.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        imageSrc: animationAssets.splashScreen,
        //  displayLoading: false,
      ),
    );
  }
}