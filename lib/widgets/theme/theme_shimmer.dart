import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../styles/app_size.dart';


class ThemeShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? baseColor;
  final Color? highlightColor;
  final Color? containerColor;
  final double? borderRadius;

  late final ShapeBorder shapeBorder;

  ThemeShimmer.rectangular({
    super.key,
    this.width = double.infinity,
    this.height,
    this.baseColor,
    this.highlightColor,
    this.containerColor,
    this.borderRadius,
  }) {
    shapeBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? AppSize.size_6));
  }

  ThemeShimmer.circular({
    super.key,
    this.width = 64,
    this.height = 64,
    this.baseColor,
    this.highlightColor,
    this.containerColor,
    this.borderRadius,
  }) {
    shapeBorder = const CircleBorder();
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Theme.of(context).highlightColor,
      highlightColor: highlightColor ?? Theme.of(context).highlightColor.withOpacity(0.1),
      child: Container(
        width: width,
        height: height ?? AppSize.size_16,
        decoration: ShapeDecoration(
          color: containerColor ?? Theme.of(context).highlightColor,
          shape: shapeBorder,
        ),
      ),
    );
  }
}
