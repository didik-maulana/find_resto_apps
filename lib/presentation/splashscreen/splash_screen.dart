import 'package:find_resto/helper/image_asset_helper.dart';
import 'package:find_resto/presentation/home/home_screen.dart';
import 'package:find_resto/presentation/views/foundation/color_palette.dart';
import 'package:find_resto/presentation/views/image_loader_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 1500))
        .then((_) => Navigator.pushReplacementNamed(context, HomeScreen.route));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.islamicGreen,
      body: Center(
        child: ImageLoaderView(
          width: 240.0,
          imageAssets: ImageAssetHelper.getImagePath('ic_app_name'),
        ),
      ),
    );
  }
}
