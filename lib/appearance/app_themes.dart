import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/app_color.dart';

class AppThemes {
  static final lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: AppColor.black,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.paleLilac,
      selectedItemColor: AppColor.eerieBlack,
      unselectedItemColor: AppColor.lightShadeGray,
    ),
    colorScheme: const ColorScheme.light(
      secondary: AppColor.offWhiteColor,
      tertiary: AppColor.black,
      primaryContainer: AppColor.offWhiteColor,
      // secondaryContainer: AppColor.offWhiteColor,
      // tertiaryContainer: AppColor.offWhiteColor,
      surface: AppColor.lotion,
    ),
    // cardColor: AppColor.offWhiteColor,
    // dialogBackgroundColor: AppColor.offWhiteColor,
    dividerColor: AppColor.shadeGray,
    // dividerTheme: const DividerThemeData(
    //   color: AppColor.paleGrayColor,
    // ),
    highlightColor: Colors.grey.shade300,
    iconTheme: const IconThemeData(
      color: AppColor.black,
    ),
    // unselectedWidgetColor: AppColor.grayColor,
    // scaffoldBackgroundColor: AppColor.whiteColor,
    // tabBarTheme: const TabBarTheme(
    //   unselectedLabelColor: AppColor.blackColor,
    //   labelColor: AppColor.whiteColor,
    // ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(
        color: AppColor.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.deepCharcoal,
      selectedItemColor: AppColor.lotion,
      unselectedItemColor: AppColor.dimGray,
    ),
    colorScheme: const ColorScheme.dark(
      secondary: AppColor.oil,
      tertiary: AppColor.black,
      primaryContainer: AppColor.oil,
      // secondaryContainer: AppColor.whiteColor,
      // tertiaryContainer: AppColor.lightCharcoalColor,
      surface: AppColor.eerieBlack,
    ),
    // cardColor: AppColor.steelBlueColor,
    // dialogBackgroundColor: AppColor.darkCharcoalColor,
    dividerColor: AppColor.darkGray,
    // dividerTheme: const DividerThemeData(
    //   color: AppColor.lightCharcoalColor,
    // ),
    highlightColor: Colors.grey.shade800,
    iconTheme: const IconThemeData(
      color: AppColor.white,
    ),
    // unselectedWidgetColor: AppColor.lightGrayColor,
    // scaffoldBackgroundColor: AppColor.darkCharcoalColor,
    // tabBarTheme: const TabBarTheme(
    //   unselectedLabelColor: AppColor.whiteColor,
    //   labelColor: AppColor.whiteColor,
    // ),
  );
}
