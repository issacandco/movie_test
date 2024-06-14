import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class GeneralUtil {
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static void transparentStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  static void changeStatusBarColor({Color? color}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color ?? Colors.transparent,
      ),
    );
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  static Future<String?> getDeviceId() async {
    return FlutterUdid.consistentUdid;
  }

  static Future<Map<String, String>> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return {
      'packageName': packageInfo.packageName,
      'appName': packageInfo.appName,
      'buildNumber': packageInfo.buildNumber,
      'appVersion': packageInfo.version,
    };
  }

  static void deleteFile(File? file) async {
    try {
      if (file == null) return;
      if (await file.exists()) file.deleteSync();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Size getDeviceSize(BuildContext context) {
    var pixelRatio = View.of(context).devicePixelRatio;
    var logicalScreenSize = View.of(context).physicalSize / pixelRatio;

    return logicalScreenSize;
  }

  static String getCurrentLocale(BuildContext context) {
    Locale? locale = Localizations.maybeLocaleOf(context);
    if (locale != null) {
      return locale.toString();
    } else {
      return Intl.systemLocale.toString();
    }
  }
}
