import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize {
  AppSize._();

  static double size_1 = 1.0.w;
  static double size_2 = 2.0.w;
  static double size_3 = 3.0.w;
  static double size_4 = 4.0.w;
  static double size_5 = 5.0.w;
  static double size_6 = 6.0.w;
  static double size_7 = 7.0.w;
  static double size_8 = 8.0.w;
  static double size_9 = 9.0.w;
  static double size_10 = 10.0.w;
  static double size_11 = 11.0.w;
  static double size_12 = 12.0.w;
  static double size_13 = 13.0.w;
  static double size_14 = 14.0.w;
  static double size_15 = 15.0.w;

  static double size_16 = 16.0.w;
  static double size_18 = 18.0.w;
  static double size_20 = 20.0.w;
  static double size_24 = 24.0.w;
  static double size_25 = 25.0.w;
  static double size_28 = 28.0.w;
  static double size_30 = 30.0.w;
  static double size_32 = 32.0.w;
  static double size_34 = 34.0.w;
  static double size_36 = 36.0.w;
  static double size_40 = 40.0.w;
  static double size_42 = 42.0.w;
  static double size_44 = 44.0.w;
  static double size_48 = 48.0.w;
  static double size_54 = 54.0.w;
  static double size_60 = 60.0.w;
  static double size_64 = 64.0.w;
  static double size_96 = 96.0.w;

  static double standardSize = size_24;

  static double textSize_10 = 10.0.sp;
  static double textSize_11 = 11.0.sp;
  static double textSize_12 = 12.0.sp;
  static double textSize_13 = 13.0.sp;
  static double textSize_14 = 14.0.sp;
  static double textSize_15 = 15.0.sp;
  static double textSize_16 = 16.0.sp;
  static double textSize_18 = 18.0.sp;
  static double textSize_20 = 20.0.sp;
  static double textSize_22 = 22.0.sp;
  static double textSize_24 = 24.0.sp;
  static double textSize_28 = 28.0.sp;
  static double textSize_32 = 32.0.sp;
  static double textSize_36 = 36.0.sp;
  static double textSize_40 = 40.0.sp;
  static double textSize_44 = 44.0.sp;
  static double textSize_48 = 48.0.sp;

  static double standardTextSize = textSize_16;

  static double getSize(double size) => size.w;

  static double getTextSize(double size) => size.sp;

  static double getScreenWidth({int? percent}) => percent != null ? (percent / 100).sw : ScreenUtil().screenWidth;

  static double getScreenHeight({int? percent}) => percent != null ? (percent / 100).sh : ScreenUtil().screenHeight;

  static double? getPixelRatio() => ScreenUtil().pixelRatio;

  static double getBodyHeight() => AppSize.getScreenHeight() - (ScreenUtil().statusBarHeight + kToolbarHeight);
}
