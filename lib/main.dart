import 'package:find_resto/presentation/splashscreen/splash_screen.dart';
import 'package:find_resto/presentation/views/foundation/color_palette.dart';
import 'package:find_resto/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Find Resto",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: ColorPalette.islamicGreen,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'NunitoSansRegular'
    ),
    home: SplashScreen(),
    onGenerateRoute: AppRouter.generateRoute,
  ));
}
