import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../logical/urls.dart';
import '../../styles/assets.dart';
import '../../styles/colors.dart';
import '../loading_widget.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    this.pathUrl,
    this.fullUrl,
    this.file,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.borderRadius,
    this.onTap,
    this.withLoading = true,
  });
  final bool withLoading;
  final VoidCallback? onTap;
  final String? pathUrl, fullUrl;
  final File? file;
  final double? borderRadius, height, width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: onTap,
        child: ((pathUrl != null || fullUrl != null)
                ? CachedNetworkImage(
                    imageUrl: pathUrl != null ? getMediaUrl(pathUrl!) : fullUrl!,
                    fit: fit,
                    placeholder: (_, __) => withLoading ? const LoadingWidget() : Container(color: MyColors.lightGrey),
                    errorWidget: (_, __, ___) => _DefaultImage(fit: fit))
                : _DefaultImage(fit: fit))
            .clipRRect(all: borderRadius),
      ),
    );
  }
}

class _DefaultImage extends StatelessWidget {
  const _DefaultImage({
    required this.fit,
  });

  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.assetsIconsNoImageIcon,
    ).center();
  }
}
