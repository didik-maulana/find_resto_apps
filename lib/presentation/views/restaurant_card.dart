import 'package:find_resto/presentation/views/foundation/app_text_style.dart';
import 'package:find_resto/presentation/views/icon_text_view.dart';
import 'package:find_resto/presentation/views/image_loader_view.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String title;
  final String description;
  final String ratingText;
  final String imageUrl;
  final GestureTapCallback onTap;

  final EdgeInsets margin;

  RestaurantCard({
    Key key,
    this.title,
    this.description,
    this.ratingText,
    this.imageUrl,
    this.onTap,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      margin: margin,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageRounded(),
              _buildInformationExpanded(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageRounded() {
    return ImageLoaderView(
      width: 100.0,
      height: 100.0,
      imageUrl: imageUrl,
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  Widget _buildInformationExpanded() {
    return Expanded(
      child: Container(
        height: 100.0,
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              style: AppTextStyle.subtitle(),
            ),
            SizedBox(height: 4.0),
            Text(
              description,
              maxLines: 2,
              style: AppTextStyle.caption(),
            ),
            Spacer(),
            IconTextView(
              iconData: Icons.star,
              iconSize: 16.0,
              iconColor: Colors.orangeAccent,
              text: ratingText,
              textStyle: AppTextStyle.caption(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
