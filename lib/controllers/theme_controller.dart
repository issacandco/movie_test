import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../appearance/app_themes.dart';
import '../base/base_view_model.dart';
import '../utils/constant_util.dart';
import '../utils/get_storage_util.dart';
import '../utils/get_util.dart';

enum ThemeModeType { system, light, dark }

class ThemeController extends BaseViewModel {
  Rx<ThemeModeType> themeTypeStream = ThemeModeType.system.obs;

  Future<void> initTheme() async {
    await getThemeStatus();
    changeTheme();
  }

  void setThemeType(ThemeModeType value) {
    themeTypeStream.value = value;
    saveThemeStatus();
    changeTheme();
  }

  changeTheme() {
    if (themeTypeStream.value == ThemeModeType.light) {
      GetUtil.changeTheme(AppThemes.lightTheme);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    } else if (themeTypeStream.value == ThemeModeType.dark) {
      GetUtil.changeTheme(AppThemes.darkTheme);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      if (brightness == Brightness.dark) {
        GetUtil.changeTheme(AppThemes.darkTheme);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      } else {
        GetUtil.changeTheme(AppThemes.lightTheme);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      }
    }
  }

  void saveThemeStatus() {
    GetStorageUtil.saveIntoGetStorage(key: ConstantUtil.keyTheme, value: themeTypeStream.value.name.toString());
  }

  Future<void> getThemeStatus() async {
    String? themeType = GetStorageUtil.readFromGetStorage<String>(key: ConstantUtil.keyTheme);

    switch (themeType) {
      case 'light':
        themeTypeStream.value = ThemeModeType.light;
        break;
      case 'dark':
        themeTypeStream.value = ThemeModeType.dark;
        break;
      default:
        themeTypeStream.value = ThemeModeType.system;
        break;
    }
  }
}
