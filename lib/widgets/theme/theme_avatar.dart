import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


import '../../styles/app_size.dart';
import 'theme_shimmer.dart';

class ThemeAvatar extends StatelessWidget {
  const ThemeAvatar({
    super.key,
    this.imageUrl,
    this.errorPlaceHolder,
    this.placeholder,
    this.size,
    this.defaultImageUrl = 'assets/images/image_avatar.png',
    this.attachmentImageUrl,
  });

  final String? imageUrl;
  final Widget? errorPlaceHolder;
  final Widget? placeholder;
  final double? size;
  final String? defaultImageUrl;
  final String? attachmentImageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return _buildDefaultPlaceHolder();
    }

    if (attachmentImageUrl != null) {
      return CircleAvatar(
        backgroundImage: FileImage(File(attachmentImageUrl!)),
        radius: size ?? AppSize.size_24,
      );
    }

    return imageUrl!.startsWith('http')
        ? CachedNetworkImage(
            placeholder: (context, url) => _buildDefaultPlaceHolder(),
            errorWidget: (context, url, error) => errorPlaceHolder ?? const Icon(Icons.error),
            fit: BoxFit.contain,
            imageUrl: imageUrl!,
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(
                radius: size ?? AppSize.size_24,
                backgroundImage: imageProvider,
              );
            },
          )
        : CircleAvatar(
            backgroundImage: AssetImage(defaultImageUrl!),
            radius: size ?? AppSize.size_24,
          );
  }

  Widget _buildDefaultPlaceHolder() {
    return CircleAvatar(
      radius: size ?? AppSize.size_24,
      child: placeholder ??
          ThemeShimmer.circular(
            width: AppSize.getSize(100),
            height: AppSize.getSize(100),
          ),
    );
  }
}
