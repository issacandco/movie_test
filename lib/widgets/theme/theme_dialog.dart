import 'package:flutter/material.dart';

import '../../styles/app_color.dart';
import '../../styles/app_size.dart';
import '../../styles/app_text_style.dart';
import '../../utils/get_util.dart';


class ThemeDialog {
  static Future<T?> show<T>({
    String? title,
    String? message,
    String? positiveLabel,
    String? negativeLabel,
    VoidCallback? positiveAction,
    VoidCallback? negativeAction,
    List<Widget>? actionList,
    Color? backgroundColor,
    Color? positiveBackgroundColor,
    bool? barrierDismissible,
    double? paddingSize,
    WrapAlignment? wrapAlignment,
    bool isDefaultActionEnabled = true,
    bool isAutoDismissDialog = true,
    Widget? child,
  }) async {
    return GetUtil.showDialog(
      _ThemeDialogWidget(
        title,
        message,
        positiveLabel: positiveLabel,
        negativeLabel: negativeLabel,
        positiveAction: positiveAction,
        negativeAction: negativeAction,
        actionList: actionList,
        backgroundColor: backgroundColor,
        positiveBackgroundColor: positiveBackgroundColor,
        barrierDismissible: barrierDismissible,
        paddingSize: paddingSize,
        wrapAlignment: wrapAlignment,
        isDefaultActionEnabled: isDefaultActionEnabled,
        isAutoDismissDialog: isAutoDismissDialog,
        child: child,
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}

class _ThemeDialogWidget extends StatelessWidget {
  final String? title, message;
  final String? positiveLabel, negativeLabel;
  final VoidCallback? positiveAction, negativeAction;
  final List<Widget>? actionList;
  final Color? backgroundColor;
  final Color? positiveBackgroundColor;
  final bool? barrierDismissible;
  final double? paddingSize;
  final WrapAlignment? wrapAlignment;
  final bool isDefaultActionEnabled;
  final bool isAutoDismissDialog;
  final Widget? child;

  const _ThemeDialogWidget(
    this.title,
    this.message, {
    this.positiveLabel,
    this.negativeLabel,
    this.positiveAction,
    this.negativeAction,
    this.actionList,
    this.backgroundColor,
    this.positiveBackgroundColor,
    this.barrierDismissible,
    this.paddingSize,
    this.wrapAlignment,
    required this.isDefaultActionEnabled,
    required this.isAutoDismissDialog,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: barrierDismissible ?? true,
      child: _buildDialogWidget(context),
    );
  }

  Widget _buildDialogWidget(BuildContext context) {
    List<Widget> actionWidgetList = _buildActionWidgets(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSize.size_8,
        ),
      ),
      insetPadding: EdgeInsets.all(
        AppSize.standardSize,
      ),
      elevation: 0,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(paddingSize ?? AppSize.size_16),
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(
              AppSize.size_8,
            ),
          ),
          child: child ??
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        title != null
                            ? Container(
                                margin: EdgeInsets.only(bottom: AppSize.size_24),
                                child: Text(
                                  title ?? '',
                                  style: AppTextStyle.customTextStyle(
                                    fontSize: AppSize.textSize_16,
                                    fontWeightType: FontWeightType.bold,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        message != null
                            ? Text(
                                message ?? '',
                                style: AppTextStyle.customTextStyle(
                                  fontSize: AppSize.textSize_16,
                                  fontWeightType: FontWeightType.medium,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.size_16),
                  Column(
                    children: actionWidgetList
                        .asMap()
                        .entries
                        .map((e) => Container(
                              margin: e.value == actionWidgetList.last ? EdgeInsets.zero : EdgeInsets.only(bottom: AppSize.size_8),
                              child: e.value,
                            ))
                        .toList(),
                  ),
                ],
              ),
        ),
      ),
    );
  }

  List<Widget> _buildActionWidgets(BuildContext context) {
    List<Widget> actionWidgetList = [];
    if (!isDefaultActionEnabled) {
      return actionWidgetList;
    } else {
      actionWidgetList.add(ActionButton(
        label: positiveLabel ?? 'OK',
        onPressed: () {
          if (isAutoDismissDialog) {
            GetUtil.back();
          }
          positiveAction?.call();
        },
        backgroundColor: positiveBackgroundColor ?? AppColor.primaryColor,
      ));

      if (negativeAction != null) {
        actionWidgetList.add(ActionButton(
          label: negativeLabel ?? 'Cancel',
          onPressed: () {
            if (isAutoDismissDialog) {
              GetUtil.back();
            }
            negativeAction?.call();
          },
          isNegativeAction: true,
          fontColor: Theme.of(context).colorScheme.primary,
        ));
      }

      if (actionList != null && actionList!.isNotEmpty) {
        actionWidgetList.addAll(actionList!);
      }
    }
    return actionWidgetList;
  }
}

class ActionButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? fontColor;
  final bool isNegativeAction;

  const ActionButton({
    super.key,
    this.label,
    this.onPressed,
    this.backgroundColor,
    this.fontColor,
    this.isNegativeAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSize.size_10),
      decoration: BoxDecoration(
        color: !isNegativeAction ? backgroundColor ?? AppColor.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(
          AppSize.size_4,
        ),
        border: Border.all(
          color: isNegativeAction ? AppColor.gray : Colors.transparent,
          width: AppSize.size_1,
        ),
      ),
      width: double.infinity,
      child: InkWell(
        onTap: onPressed,
        child: Text(
          label ?? '',
          style: AppTextStyle.customTextStyle(
            fontSize: AppSize.textSize_14,
            color: fontColor ?? AppColor.white,
            fontWeightType: FontWeightType.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
