import 'package:flutter/material.dart';

import '../../styles/app_color.dart';
import '../../styles/app_size.dart';
import '../../styles/app_text_style.dart';


enum FitType { fit, loose }

class ThemeButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Widget? icon;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? color;
  final Color? borderColor;
  final Color? disabledColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final bool? enabled;
  final bool showShadow;
  final FitType fitType;

  late final bool secondary;

  ThemeButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.textStyle,
    this.textColor,
    this.color = AppColor.primaryColor,
    this.disabledColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.enabled = true,
    this.showShadow = false,
    this.fitType = FitType.loose,
  }) {
    secondary = false;
  }

  ThemeButton.secondary({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.textStyle,
    this.textColor,
    this.color,
    this.disabledColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.enabled = true,
    this.showShadow = false,
    this.fitType = FitType.loose,
  }) {
    secondary = true;
  }

  @override
  Widget build(BuildContext context) {
    return fitType == FitType.loose
        ? AnimatedContainer(
            decoration: secondary
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius ?? BorderRadius.circular(AppSize.size_8),
                    border: Border.all(color: borderColor ?? Colors.grey),
                  )
                : BoxDecoration(
                    gradient: enabled ?? true
                        ? LinearGradient(colors: [
                            color ?? AppColor.primaryColor,
                            color ?? AppColor.primaryColor,
                          ])
                        : LinearGradient(colors: [
                            color?.withOpacity(0.5) ?? AppColor.primaryColor.withOpacity(0.5),
                            color?.withOpacity(0.5) ?? AppColor.primaryColor.withOpacity(0.5),
                          ]),
                    borderRadius: borderRadius ?? BorderRadius.circular(AppSize.size_8),
                    border: Border.all(color: borderColor ?? Colors.transparent)),
            duration: const Duration(milliseconds: 500),
            child: Wrap(
              children: [
                TextButton.icon(
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    padding: MaterialStateProperty.all(
                      padding ??
                          EdgeInsets.only(
                            top: AppSize.size_8,
                            bottom: AppSize.size_8,
                            left: AppSize.size_24,
                            right: AppSize.size_24,
                          ),
                    ),
                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.transparent;
                      },
                    ),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: enabled ?? true ? onPressed : null,
                  label: Text(
                    text,
                    style: textStyle ??
                        AppTextStyle.customTextStyle(
                          fontSize: AppSize.textSize_16,
                          color: _getTextColor(),
                          fontWeightType: FontWeightType.bold,
                        ),
                  ),
                  icon: icon ?? const SizedBox.shrink(),
                ),
              ],
            ))
        : AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: AppSize.getScreenWidth(),
            decoration: secondary
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius ?? BorderRadius.circular(AppSize.size_8),
                    border: Border.all(color: borderColor ?? Colors.grey),
                  )
                : BoxDecoration(
                    gradient: enabled ?? true
                        ? LinearGradient(colors: [
                            color ?? AppColor.primaryColor,
                            color ?? AppColor.primaryColor,
                          ])
                        : LinearGradient(colors: [
                            color?.withOpacity(0.5) ?? AppColor.primaryColor.withOpacity(0.5),
                            color?.withOpacity(0.5) ?? AppColor.primaryColor.withOpacity(0.5),
                          ]),
                    borderRadius: borderRadius ?? BorderRadius.circular(AppSize.size_8),
                    border: Border.all(color: borderColor ?? Colors.transparent)),
            child: TextButton.icon(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  padding ??
                      EdgeInsets.only(
                        top: AppSize.size_8,
                        bottom: AppSize.size_8,
                        left: AppSize.size_24,
                        right: AppSize.size_24,
                      ),
                ),
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Colors.transparent;
                  },
                ),
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed: enabled ?? true ? onPressed : null,
              label: Text(
                text,
                style: textStyle ??
                    AppTextStyle.customTextStyle(
                      fontSize: AppSize.textSize_16,
                      color: _getTextColor(),
                      fontWeightType: FontWeightType.bold,
                    ),
              ),
              icon: icon ?? const SizedBox.shrink(),
            ),
          );
  }

  Color _getTextColor() {
    if (enabled ?? true) {
      return secondary ? (textColor ?? Colors.black) : (textColor ?? Colors.white);
    } else {
      return secondary ? (textColor?.withOpacity(0.5) ?? Colors.black.withOpacity(0.5)) : (textColor?.withOpacity(0.5) ?? Colors.white.withOpacity(0.5));
    }
  }
}
