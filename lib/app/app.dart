import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../appearance/app_themes.dart';
import '../controllers/theme_controller.dart';
import '../dependencies/dependencies.dart';
import '../languages/messages.dart';
import '../routes/app_router.dart';
import '../screens/error/error_screen.dart';
import '../screens/unknown/unknown_screen.dart';
import '../utils/constant_util.dart';
import '../utils/general_util.dart';
import '../utils/get_storage_util.dart';
import '../utils/get_util.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  late ThemeController _themeController;

  @override
  void initState() {
    super.initState();
    _themeController = GetUtil.put(ThemeController());


    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAppTheme();
    });
  }

  _initAppTheme() async {
    await _themeController.initTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: GeneralUtil.getDeviceSize(context),
      builder: (BuildContext context, Widget? widget) => GetUtil.getX<ThemeController>(
        builder: (vm) {
          ThemeMode themeMode;

          switch (vm.themeTypeStream.value) {
            case ThemeModeType.light:
              themeMode = ThemeMode.light;
              break;
            case ThemeModeType.dark:
              themeMode = ThemeMode.dark;
              break;
            default:
              // themeMode = ThemeMode.system;
              themeMode = ThemeMode.light;
              break;
          }

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: ConstantUtil.appName,
            translations: Messages(),
            fallbackLocale: const Locale('en', 'US'),
            locale: GetStorageUtil.readFromGetStorage<String>(key: 'lang') == null || GetStorageUtil.readFromGetStorage<String>(key: 'lang') == 'en' ? const Locale('en', 'US') : const Locale('zh', 'CN'),
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeMode,
            initialBinding: Dependencies(),
            defaultTransition: GetUtil.getTransitionType(TransitionType.rightToLeft),
            getPages: AppRouter.route,
            initialRoute: '/splashScreen',
            unknownRoute: GetPage(
              name: '/unknownScreen',
              page: () => const UnknownScreen(),
              transition: Transition.fade,
            ),
            navigatorObservers: const [
              // FlutterServices.getFirebaseAnalyticsObserver(),
            ],
            builder: (BuildContext context, Widget? widget) {
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                return ErrorScreen(
                  errorMessage: errorDetails.summary.toString(),
                );
              };
              return widget!;
            },
          );
        },
      ),
    );
  }
}
