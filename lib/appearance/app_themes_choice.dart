import 'package:flutter/material.dart';

import '../controllers/theme_controller.dart';
import '../styles/app_color.dart';
import '../styles/app_size.dart';
import '../styles/app_text_style.dart';
import '../utils/get_util.dart';
import '../widgets/theme/theme_radio_button.dart';

class AppThemeChoice extends StatelessWidget {
  const AppThemeChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(AppSize.standardSize),
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              _buildTitleBar(),
              _buildAppThemeChoiceList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleBar() {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Appearance',
            style: AppTextStyle.customTextStyle(
              fontSize: AppSize.textSize_22,
              fontWeightType: FontWeightType.bold,
            ),
          ),
          InkWell(
            onTap: () {
              GetUtil.back();
            },
            child: CircleAvatar(
              radius: AppSize.size_18,
              backgroundColor: AppColor.primaryColor,
              child: const Icon(
                Icons.close,
                color: AppColor.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAppThemeChoiceList() => GetUtil.getX<ThemeController>(
        builder: (vm) {
          return Column(
            children: [
              ThemeRadioButton<ThemeModeType>(
                value: ThemeModeType.system,
                groupValue: vm.themeTypeStream.value,
                label: 'same_as_device'.translate(),
                labelWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'same_as_device'.translate(),
                      style: AppTextStyle.customTextStyle(
                        fontSize: AppSize.textSize_16,
                      ),
                    ),
                    Text(
                      'desc_same_as_device'.translate(),
                      style: AppTextStyle.customTextStyle(
                        fontSize: AppSize.textSize_14,
                        color: AppColor.gray,
                      ),
                    ),
                  ],
                ),
                onChanged: (value) {
                  vm.setThemeType(value);
                },
              ),
              ThemeRadioButton<ThemeModeType>(
                value: ThemeModeType.light,
                groupValue: vm.themeTypeStream.value,
                label: 'light'.translate(),
                onChanged: (value) {
                  vm.setThemeType(value);
                },
              ),
              ThemeRadioButton<ThemeModeType>(
                value: ThemeModeType.dark,
                groupValue: vm.themeTypeStream.value,
                label: 'dark'.translate(),
                onChanged: (value) {
                  vm.setThemeType(value);
                },
              ),
            ],
          );
        },
      );
}
