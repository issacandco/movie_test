import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/app_color.dart';
import '../../styles/app_size.dart';
import '../../styles/app_text_style.dart';


class ThemeTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String value) onTextChanged;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool enabled;
  final bool readOnly;
  final bool showCounter;
  final bool isPassword;
  final Color? fillColor;
  final Color? disabledColor;

  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatterList;
  final TextCapitalization? textCapitalization;
  final TextAlign? textAlign;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final String? Function(String? value)? validator;
  final Function(String? textValue)? onFieldSubmitted;
  final FormFieldSetter<dynamic>? onSaved;
  final Iterable<String>? autofillHints;

  final InputDecoration? decoration;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final double? labelFontSize;
  final Color? labelColor;
  final TextStyle? inputTextStyle;
  final double? inputTextFontSize;
  final Color? inputTextColor;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final double? hintTextFontSize;
  final Color? hintTextColor;
  final String? errorText;
  final TextStyle? errorTextStyle;
  final double? errorTextFontSize;
  final Color? errorTextColor;
  final InputBorder? inputBorder;
  final double? inputBorderRadius;
  final Color? inputBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;

  const ThemeTextField({
    super.key,
    this.controller,
    required this.onTextChanged,
    this.focusNode,
    this.nextFocus,
    this.enabled = true,
    this.readOnly = false,
    this.showCounter = false,
    this.isPassword = false,
    this.fillColor,
    this.disabledColor,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textInputFormatterList,
    this.textCapitalization = TextCapitalization.words,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.validator,
    this.onFieldSubmitted,
    this.onSaved,
    this.autofillHints,
    this.decoration,
    this.labelText,
    this.labelTextStyle,
    this.labelFontSize,
    this.labelColor,
    this.inputTextStyle,
    this.inputTextFontSize,
    this.inputTextColor,
    this.hintText,
    this.hintTextStyle,
    this.hintTextFontSize,
    this.hintTextColor,
    this.errorText,
    this.errorTextStyle,
    this.errorTextFontSize,
    this.errorTextColor,
    this.inputBorder,
    this.inputBorderRadius,
    this.inputBorderColor,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.contentPadding,
  });

  @override
  State<StatefulWidget> createState() => _ThemeTextFieldState();
}

class _ThemeTextFieldState extends State<ThemeTextField> {
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;
  late bool _showPassword;

  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _showPassword = widget.isPassword;
    _textEditingController = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _textEditingController.addListener(
      () {
        if (_textEditingController.text.isNotEmpty) {
          setState(() {
            _hasText = true;
          });
        } else {
          _hasText = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      onChanged: widget.onTextChanged,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.textInputFormatterList,
      textCapitalization: widget.textCapitalization!,
      textAlign: widget.textAlign!,
      maxLength: widget.maxLength,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      minLines: widget.minLines,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: _showPassword,
      cursorColor: widget.inputBorderColor,
      style: _defaultInputTextStyle(),
      onSaved: widget.onSaved,
      autofillHints: widget.autofillHints,
      decoration: widget.decoration ??
          InputDecoration(
            filled: true,
            fillColor: widget.enabled ? widget.fillColor ?? Colors.transparent : widget.disabledColor ?? AppColor.darkGray.withOpacity(0.5),
            prefix: widget.prefix,
            prefixIcon: widget.prefixIcon,
            suffix: widget.suffix,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: _hasText,
                  child: IconButton(
                    icon: const Icon(
                      CupertinoIcons.clear_circled,
                    ),
                    onPressed: () {
                      setState(() {
                        _textEditingController.clear();
                      });
                    },
                  ),
                ),
                widget.isPassword ? _passwordIcon() : widget.suffixIcon ?? const SizedBox.shrink(),
              ],
            ),
            labelText: widget.labelText,
            labelStyle: _defaultLabelTextStyle(),
            hintText: widget.hintText,
            hintStyle: _defaultHintTextStyle(),
            errorText: widget.errorText,
            errorStyle: _defaultErrorTextStyle(),
            border: _defaultInputBorder(),
            enabledBorder: _defaultInputBorder(),
            disabledBorder: _defaultDisabledBorder(),
            errorBorder: _defaultErrorBorder(),
            focusedBorder: _defaultFocusedBorder(),
            focusedErrorBorder: _defaultErrorBorder(),
            contentPadding: _defaultContentPadding(),
            counterText: widget.showCounter ? null : '',
          ),
    );
  }

  Widget _passwordIcon() {
    return _showPassword
        ? IconButton(
            icon: Icon(
              CupertinoIcons.eye,
              color: widget.labelColor,
            ),
            onPressed: () {
              setState(() {
                _showPassword = false;
              });
            },
          )
        : IconButton(
            icon: Icon(
              CupertinoIcons.eye_slash,
              color: widget.labelColor,
            ),
            onPressed: () {
              setState(() {
                _showPassword = true;
              });
            },
          );
  }

  TextStyle _defaultLabelTextStyle() =>
      widget.labelTextStyle ??
      AppTextStyle.customTextStyle(
        fontSize: widget.labelFontSize ?? AppSize.standardTextSize,
        color: widget.labelColor ?? Colors.black,
        fontWeightType: FontWeightType.bold,
      );

  TextStyle _defaultInputTextStyle() =>
      widget.inputTextStyle ??
      AppTextStyle.customTextStyle(
        fontSize: widget.inputTextFontSize ?? AppSize.standardTextSize,
        color: widget.inputTextColor,
      );

  TextStyle _defaultHintTextStyle() =>
      widget.hintTextStyle ??
      AppTextStyle.customTextStyle(
        fontSize: widget.hintTextFontSize ?? AppSize.standardTextSize,
        color: widget.hintTextColor ?? Colors.grey,
      );

  TextStyle _defaultErrorTextStyle() =>
      widget.errorTextStyle ??
      AppTextStyle.customTextStyle(
        fontSize: widget.errorTextFontSize ?? AppSize.textSize_14,
        color: widget.errorTextColor ?? Colors.red,
      );

  InputBorder _defaultInputBorder() =>
      widget.inputBorder ??
      _inputBorder(
        borderRadius: widget.inputBorderRadius,
        borderColor: widget.inputBorderColor,
      );

  InputBorder _defaultFocusedBorder() => _inputBorder(
        borderRadius: widget.inputBorderRadius,
        borderColor: widget.inputBorderColor,
        width: 2,
      );

  InputBorder _defaultDisabledBorder() => _inputBorder(
        borderRadius: widget.inputBorderRadius,
        borderColor: widget.disabledColor ?? AppColor.darkGray,
      );

  InputBorder _defaultErrorBorder() => _inputBorder(
        borderRadius: widget.inputBorderRadius,
        borderColor: widget.errorTextColor ?? Colors.red,
      );

  InputBorder _inputBorder({double? borderRadius, Color? borderColor, double? width = 1.0}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? AppSize.size_8),
        borderSide: BorderSide(
          color: borderColor ?? Colors.transparent,
          width: width!,
        ),
      );

  EdgeInsetsGeometry _defaultContentPadding() =>
      widget.contentPadding ??
      EdgeInsets.symmetric(
        horizontal: AppSize.size_16,
        vertical: AppSize.size_8,
      );
}
