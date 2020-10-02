import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerView extends StatelessWidget {
  final double width;
  final double height;
  final Duration duration;

  ShimmerView({
    Key key,
    this.width,
    this.height,
    this.duration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey[400],
      period: duration,
      child: Container(
        color: Colors.black26,
        width: width,
        height: height,
      ),
    );
  }
}
