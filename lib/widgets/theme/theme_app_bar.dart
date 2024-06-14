import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/app_size.dart';
import '../../styles/app_text_style.dart';
import '../../utils/get_util.dart';


enum IconType {
  menu,
  close,
  none,
  back,
}

class ThemeAppBar extends AppBar {
  final IconType? iconType;
  final Widget? icon;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final String? titleName;
  final Color? titleNameColor;
  final Color? appBarColor;
  final Widget? titleWidget;
  final PreferredSize? bottomWidget;
  final List<Widget>? appBarActions;
  final bool centerTitleName;
  final bool hideElevation;
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  ThemeAppBar({
    this.iconType = IconType.back,
    this.icon,
    this.iconColor,
    this.onPressed,
    this.titleName,
    this.titleNameColor,
    this.appBarColor = Colors.transparent,
    this.titleWidget,
    this.bottomWidget,
    this.appBarActions,
    this.centerTitleName = true,
    this.hideElevation = false,
    this.systemUiOverlayStyle,
    super.key,
  }) : super(
          leading: iconType == IconType.menu
              ? IconButton(
                  onPressed: onPressed,
                  icon: icon ??
                      Icon(
                        Icons.menu,
                        color: iconColor,
                      ))
              : iconType == IconType.none
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: onPressed ??
                          () {
                            GetUtil.back();
                          },
                      icon: icon ??
                          Icon(
                            Icons.arrow_back,
                            color: iconColor,
                          ),
                    ),
          leadingWidth: iconType == IconType.none ? AppSize.size_8 : null,
          centerTitle: centerTitleName,
          elevation: hideElevation ? 0 : null,
          title: titleWidget ??
              Text(
                titleName ?? '',
                style: AppTextStyle.customTextStyle(
                  fontSize: AppSize.textSize_22,
                  color: titleNameColor,
                  fontWeightType: FontWeightType.bold,
                ),
              ),
          bottom: bottomWidget,
          actions: [
            ...?appBarActions,
            SizedBox(
              width: AppSize.size_6,
            )
          ],
          backgroundColor: appBarColor,
          systemOverlayStyle: systemUiOverlayStyle,
          scrolledUnderElevation: 0,
        );
}
