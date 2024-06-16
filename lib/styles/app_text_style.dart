import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_size.dart';

enum FontWeightType { regular, medium, bold }

class AppTextStyle {
  static TextStyle getTextStyle({
    required FontWeightType? fontWeightType,
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) {
    return baseTextStyle(
      fontSize: fontSize ?? AppSize.standardTextSize,
      color: color,
      fontWeightType: fontWeightType,
      fontStyle: fontStyle ?? FontStyle.normal,
    );
  }

  static TextStyle customTextStyle({
    double? fontSize,
    Color? color,
    TextDecoration? textDecoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontWeightType? fontWeightType = FontWeightType.regular,
    bool isItalic = false,
  }) {
    return baseTextStyle(
      fontSize: fontSize,
      color: color,
      textDecoration: textDecoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      fontWeightType: fontWeightType,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static TextStyle baseTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    FontWeightType? fontWeightType,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Paint? background,
    double? decorationThickness,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    String? fontFamily,
    List<String>? fontFamilyFallback,
  }) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize ?? AppSize.standardTextSize,
        color: color ?? Get.theme.colorScheme.tertiary,
        fontWeight: fontWeight ?? _getFontWeight(fontWeightType),
        fontStyle: fontStyle ?? FontStyle.normal,
        decoration: textDecoration,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        background: background,
        decorationThickness: decorationThickness,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
      ),
    );
  }

  static FontWeight _getFontWeight(FontWeightType? fontWeightType) {
    switch (fontWeightType) {
      case FontWeightType.medium:
        return FontWeight.w500;
      case FontWeightType.bold:
        return FontWeight.w700;
      default:
        return FontWeight.w400;
    }
  }
}
