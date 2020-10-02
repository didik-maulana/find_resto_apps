import 'package:find_resto/helper/image_asset_helper.dart';
import 'package:find_resto/presentation/views/foundation/app_text_style.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String imageName;
  final String title;
  final String message;

  EmptyView({
    Key key,
    this.imageName,
    this.title,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          ImageAssetHelper.getImagePath(imageName),
          width: 160.0,
          height: 160.0,
        ),
        SizedBox(height: 24.0),
        Text(
          title,
          style: AppTextStyle.heading(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyle.body(),
          ),
        ),
      ],
    );
  }
}
