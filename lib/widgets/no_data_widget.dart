import 'package:flutter/material.dart';
import 'package:movie_test/styles/app_size.dart';
import 'package:movie_test/styles/app_text_style.dart';

class NoDataWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Color? messageColor;
  final EdgeInsets? padding;
  final bool showMessage;

  const NoDataWidget({
    super.key,
    this.message,
    this.image,
    this.messageColor,
    this.padding,
    this.showMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.only(top: AppSize.getScreenHeight(percent: 8)),
        child: Column(
          children: [
            image == null
                ? const SizedBox.shrink()
                : Container(
                    margin: EdgeInsets.only(bottom: AppSize.size_16),
                    child: image!,
                  ),
            Visibility(
              visible: showMessage,
              child: Text(
                message ?? 'No data',
                style: AppTextStyle.customTextStyle(
                  fontSize: AppSize.textSize_14,
                  fontWeightType: FontWeightType.medium,
                  color: messageColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
