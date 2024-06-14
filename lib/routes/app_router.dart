import 'package:get/get.dart';

import '../screens/splash/splash_screen.dart';

/// REFERENCE:
/// https://www.appwithflutter.com/flutter-state-management-with-getx/
/// https://pub.dev/packages/get/changelog
///
/// NOTE:
/// If without route Get.toNamed('/homeScreen/discoverScreen?Name=Law&Age=37') will thrown NoSuchMethodError.
/// Meaning to say won't be able to use dynamic link for navigation

class AppRouter {
  static final route = [
    GetPage(
      name: '/splashScreen',
      page: () => const SplashScreen(),
    ),
  ];
}
