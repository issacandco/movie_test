import 'package:flutter/material.dart';

import '../../../styles/app_color.dart';
import '../../../styles/app_size.dart';
import '../../../styles/app_text_style.dart';

class ItemCategory extends StatelessWidget {
  final Map<String, dynamic> category;
  final bool isSelected;
  final VoidCallback onTap;

  const ItemCategory({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.size_16,
          vertical: AppSize.size_8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppSize.size_8),
        ),
        child: Text(
          category['categoryName'],
          style: AppTextStyle.customTextStyle(
            fontSize: AppSize.textSize_16,
            fontWeightType: FontWeightType.medium,
            color: isSelected ? AppColor.white : Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}
