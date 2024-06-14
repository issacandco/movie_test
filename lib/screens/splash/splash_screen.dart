import 'dart:io';

import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import '../../utils/general_util.dart';
import '../../utils/get_util.dart';
import '../landing/landing_screen.dart';

enum DeviceType { ios, android, huawei }

extension DeviceTypeExtension on DeviceType {
  String get value {
    switch (this) {
      case DeviceType.ios:
        return 'IOS';
      case DeviceType.android:
        return 'ANDROID';
      case DeviceType.huawei:
        return 'HUAWEI';
      default:
        return 'UNKNOWN';
    }
  }
}

class SplashScreen extends BasePage {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> with BasicPage {
  // final AppViewModel appViewModel = GetUtil.find<AppViewModel>()!;

  @override
  void initState() {
    super.initState();

    // appViewModel.addResponseListener(
    //   onLoadingResponse: () {},
    //   onSuccessResponse: (codeType, responseData) async {
    //     switch (codeType) {
    //       case AppViewModel.codeCheckVersion:
    //         appViewModel.getServerConfig();
    //
    //         break;
    //       case AppViewModel.codeGetServerConfig:
    //         String? accessToken = GetStorageUtil.readFromGetStorage(key: ConstantUtil.keyAccessToken);
    //         if (accessToken != null) {
    //           GetUtil.offAll(
    //             const LandingScreen(),
    //             transitionType: TransitionType.fade,
    //           );
    //         } else {
    //           GetUtil.offAll(
    //             const LoginScreen(),
    //             transitionType: TransitionType.fade,
    //           );
    //         }
    //         break;
    //     }
    //   },
    //   onDoneResponse: () {},
    // );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (!mounted) return;

        String deviceType = Platform.isAndroid ? DeviceType.android.value : DeviceType.ios.value;
        Map<String, String> packageInfo = await GeneralUtil.getPackageInfo();
        // appViewModel.checkVersion(deviceType: deviceType, packageInfo: packageInfo);
        GetUtil.offAll(
          const LandingScreen(),
          transitionType: TransitionType.fade,
        );
      },
    );
  }

  @override
  Widget body() {
    return Container(alignment: Alignment.center, color: Theme.of(context).colorScheme.background, child: Container()

        // AssetUtil.icLogo(
        //   size: AppDimen.getSize(200),
        //   color: Theme.of(context).iconTheme.color,
        // ),
        );
  }
}
