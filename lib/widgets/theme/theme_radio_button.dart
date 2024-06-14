import 'package:flutter/material.dart';

import '../../styles/app_color.dart';
import '../../styles/app_size.dart';
import '../../styles/app_text_style.dart';

class ThemeRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String? label;
  final Widget? labelWidget;
  final EdgeInsets? contentPadding;
  final Color? activeColor;
  final Function(T)? onChanged;

  const ThemeRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    this.label,
    this.labelWidget,
    this.contentPadding,
    this.activeColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) onChanged?.call(value);
      },
      child: Padding(
        padding: contentPadding ??
            const EdgeInsets.symmetric(
              vertical: 8,
            ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<T>(
              groupValue: groupValue,
              value: value,
              activeColor: activeColor ?? AppColor.primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              onChanged: (selectedValue) {
                onChanged?.call(selectedValue as T);
              },
            ),
            const SizedBox(width: 8),
            _getLabel(),
          ],
        ),
      ),
    );
  }

  Widget _getLabel() {
    if (labelWidget != null) {
      return Expanded(child: labelWidget!);
    }

    if (label != null) {
      return Text(
        label ?? '',
        style: AppTextStyle.customTextStyle(
          fontSize: AppSize.textSize_16,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
