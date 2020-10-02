import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_resto/presentation/views/foundation/app_text_style.dart';
import 'package:find_resto/presentation/views/shimmer_view.dart';
import 'package:flutter/material.dart';

class ImageLoaderView extends StatelessWidget {
  final String imageUrl;
  final String imageAssets;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final String placeholderText;
  final Gradient gradient;

  static const String _defaultPlaceholderText = 'NO IMAGE';

  ImageLoaderView({
    Key key,
    this.imageUrl,
    this.imageAssets,
    this.width,
    this.height,
    this.borderRadius,
    this.placeholderText = _defaultPlaceholderText,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl?.isNotEmpty == true) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.all(Radius.zero),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
              placeholder: (context, url) => ShimmerView(),
              errorWidget: (context, url, error) => _buildImagePlaceholder(),
            ),
          ),
          _buildGradient(),
        ],
      );
    } else if (imageAssets?.isNotEmpty == true) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.all(Radius.zero),
        child: Image.asset(
          imageAssets,
          width: width,
          height: height,
        ),
      );
    } else {
      return _buildImagePlaceholder();
    }
  }

  Widget _buildGradient() {
    if (gradient != null) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          placeholderText,
          style: AppTextStyle.caption(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
