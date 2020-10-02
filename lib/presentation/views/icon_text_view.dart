import 'package:flutter/material.dart';

class IconTextView extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final String text;
  final TextStyle textStyle;

  IconTextView({
    Key key,
    this.iconData,
    this.iconSize,
    this.iconColor,
    this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: iconSize,
          color: iconColor,
        ),
        SizedBox(width: 4.0),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}
