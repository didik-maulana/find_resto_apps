import 'package:find_resto/presentation/views/foundation/color_palette.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static const _regular = 'NunitoSansRegular';
  static const _bold = 'NunitoSansBold';
  static const _semiBold = 'NunitoSansSemiBold';

  static TextStyle heading({Color textColor = ColorPalette.gray900}) {
    return TextStyle(
      fontFamily: _bold,
      fontSize: 20.0,
      color: textColor,
    );
  }

  static TextStyle subtitle({Color textColor = ColorPalette.gray900}) {
    return TextStyle(
      fontFamily: _semiBold,
      fontSize: 16.0,
      color: textColor,
    );
  }

  static TextStyle body({Color textColor = ColorPalette.gray700}) {
    return TextStyle(
      fontFamily: _regular,
      fontSize: 14.0,
      color: textColor,
    );
  }

  static TextStyle caption({
    Color textColor = ColorPalette.gray600,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontFamily: _regular,
      fontSize: 12.0,
      color: textColor,
      fontWeight: fontWeight,
    );
  }
}
