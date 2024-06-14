import 'package:flutter/material.dart';
import 'package:movie_test/styles/app_color.dart';
import 'package:movie_test/styles/app_size.dart';


class LoadingWidget extends StatelessWidget {
  static OverlayState? _overlayState;
  static OverlayEntry? _overlayEntry;

  const LoadingWidget({super.key});

  static void showLoading(BuildContext context) {
    dismissLoading();

    _overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(builder: (context) {
      return const LoadingWidget();
    });
    _overlayState!.insert(_overlayEntry!);
  }

  static void dismissLoading() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    double loadingIconSize = AppSize.getScreenWidth(percent: 30);
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Image.asset(
          'assets/gifs/loading_circle.gif',
          height: loadingIconSize,
          width: loadingIconSize,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}
