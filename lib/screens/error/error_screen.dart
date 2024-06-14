import '../../utils/get_util.dart';
import 'package:flutter/material.dart';

import '../../styles/app_size.dart';
import '../../styles/app_text_style.dart';



class ErrorScreen extends StatelessWidget {
  final String? errorMessage;
  final EdgeInsets? padding;

  const ErrorScreen({super.key, this.errorMessage, this.padding});

  @override
  Widget build(BuildContext context) {
    bool isProduction = false;

    return Container(
      height: double.infinity,
      alignment: Alignment.center,
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/image_404.png'),
          Padding(
            padding: EdgeInsets.all(AppSize.size_16),
            child: Column(
              children: [
                Text(
                  isProduction ? 'oops_something_went_wrong'.translate() : errorMessage ?? 'oops_something_went_wrong'.translate(),
                  style: AppTextStyle.customTextStyle(
                    fontSize: AppSize.textSize_18,
                    color: isProduction ? Colors.black : Colors.red,
                    fontWeightType: FontWeightType.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSize.size_16),
                isProduction
                    ? Text(
                        'error_general_message'.translate(),
                        style: AppTextStyle.customTextStyle(
                          color: Colors.black,
                          fontWeightType: FontWeightType.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
