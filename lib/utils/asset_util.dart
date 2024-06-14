import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../styles/app_size.dart';

class AssetUtil {
  AssetUtil._();

  static Widget icSearch({double? size, Color? color}) {
    size ??= AppSize.size_28;
    return SvgPicture.asset(
      'assets/icons/ic_search.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? Get.theme.iconTheme.color!, BlendMode.srcIn),
    );
  }

  static Widget icFilter({double? size, Color? color}) {
    size ??= AppSize.size_28;
    return SvgPicture.asset(
      'assets/icons/ic_filter.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? Get.theme.iconTheme.color!, BlendMode.srcIn),
    );
  }

  static Widget icClear({double? size, Color? color}) {
    size ??= AppSize.size_28;
    return SvgPicture.asset(
      'assets/icons/ic_clear.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? Get.theme.iconTheme.color!, BlendMode.srcIn),
    );
  }
}
