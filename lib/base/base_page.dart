import 'package:flutter/material.dart';

import '../utils/general_util.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
}

abstract class BaseState<Page extends BasePage> extends State<Page> with AutomaticKeepAliveClientMixin {}

mixin BasicPage<Page extends BasePage> on BaseState<Page> {
  PreferredSizeWidget? appBar() => null;

  Widget body();

  Widget? sideMenuDrawer() => null;

  Widget? bottomNavigationBar() => null;

  Widget? floatingActionButton() => null;

  bool extendBodyBehindAppBar = false;

  bool? resizeToAvoidBottomInset;

  final bool _keepAlive = false;

  GlobalKey<ScaffoldState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => GeneralUtil.hideKeyboard(context),
      child: Scaffold(
        key: globalKey,
        appBar: appBar(),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (scroll) {
            scroll.disallowIndicator();
            return true;
          },
          child: Stack(
            children: [
              body(),
              // Positioned(bottom: 28, right: 0, child: _buildInternetStatusPanel()),
            ],
          ),
        ),
        drawer: sideMenuDrawer(),
        bottomNavigationBar: bottomNavigationBar(),
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        extendBodyBehindAppBar: appBar() == null ? true : extendBodyBehindAppBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      ),
    );
  }

  // Widget _buildInternetStatusPanel() {
  //   return GetUtil.getX<ConnectivityController>(builder: (vm) {
  //     InternetStatus internetStatus = vm.internetStatusStream.value;
  //
  //     return Visibility(
  //       visible: internetStatus == InternetStatus.disconnected,
  //       child: ThemeAnimate(
  //         animationType: AnimationType.slideInRight,
  //         child: Container(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: DimenConfig.size_16,
  //             vertical: DimenConfig.size_8,
  //           ),
  //           decoration: BoxDecoration(
  //             color: ColorConfig.redColor.withOpacity(0.8),
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(DimenConfig.size_32),
  //               bottomLeft: Radius.circular(DimenConfig.size_32),
  //             ),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Image.asset(
  //                 'assets/images/gifs/loading_internet.gif',
  //                 color: ColorConfig.whiteColor,
  //                 height: DimenConfig.size_24,
  //                 width: DimenConfig.size_24,
  //               ),
  //               Text(
  //                 'no_internet_connection'.translate(),
  //                 style: TextStyleConfig.mediumTextStyle(
  //                   color: ColorConfig.whiteColor,
  //                   fontSize: DimenConfig.size_14,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  // }

  @override
  bool get wantKeepAlive => _keepAlive;
}
