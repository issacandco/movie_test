import 'package:flutter/material.dart';

import '../../styles/app_color.dart';
import '../../styles/app_size.dart';
import '../../styles/app_text_style.dart';

class ThemeCheckBox extends StatefulWidget {
  final bool value;
  final String? textMessage;
  final TextSpan? textSpan;
  final double? fontSize;
  final Color? fontColor;
  final Color enableBorderColor;
  final Color disableBorderColor;
  final Function(bool value)? onChanged;
  final bool? enabled;
  final Alignment? alignment;

  const ThemeCheckBox({
    super.key,
    this.value = false,
    this.textMessage,
    this.textSpan,
    this.fontSize,
    this.fontColor,
    this.enableBorderColor = AppColor.primaryColor,
    this.disableBorderColor = Colors.transparent,
    this.onChanged,
    this.enabled,
    this.alignment,
  });

  @override
  State<ThemeCheckBox> createState() => _ThemeCheckBoxState();
}

class _ThemeCheckBoxState extends State<ThemeCheckBox> {
  late bool checkBoxValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkBoxValue = widget.value;

    return AnimatedContainer(
      padding: EdgeInsets.symmetric(vertical: AppSize.size_4),
      duration: const Duration(milliseconds: 400),
      child: _content(),
    );
  }

  Widget _content() {
    if (widget.textMessage != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCheckBox(),
          SizedBox(width: AppSize.size_8),
          Flexible(
            child: Text(
              widget.textMessage!,
              style: AppTextStyle.customTextStyle(
                fontSize: widget.fontSize ?? AppSize.textSize_14,
                color: widget.enabled ?? true ? widget.fontColor : AppColor.darkGray,
              ),
            ),
          ),
        ],
      );
    } else if (widget.textSpan != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCheckBox(),
          SizedBox(width: AppSize.size_8),
          Flexible(child: RichText(text: widget.textSpan!)),
        ],
      );
    } else {
      return Align(
        alignment: widget.alignment ?? Alignment.centerLeft,
        child: _buildCheckBox(),
      );
    }
  }

  Widget _buildCheckBox() => InkWell(
    onTap: widget.enabled ?? true && widget.onChanged != null
        ? () {
      checkBoxValue = !checkBoxValue;
      widget.onChanged?.call(checkBoxValue);
      setState(() {});
    }
        : null,
    child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppSize.size_4,
              ),
            ),
            color: checkBoxValue
                ? widget.enabled ?? true
                    ? AppColor.primaryColor
                    : AppColor.darkGray
                : Colors.transparent,
            border: Border.all(
              color: widget.enabled ?? true
                  ? checkBoxValue
                      ? widget.enableBorderColor
                      : widget.enableBorderColor
                  : AppColor.darkGray,
              width: AppSize.size_2,
            ),
          ),
          child: Icon(
            Icons.check_rounded,
            size: AppSize.size_18,
            color: checkBoxValue ? Colors.white : Colors.transparent,
          ),
        ),
  );
}
