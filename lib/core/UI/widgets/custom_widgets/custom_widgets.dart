import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'package:easy_localization/easy_localization.dart';
import '../../../logical/utils/extensions.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width,
    this.height = 54,
    this.color,
    this.style,
    this.vPadding,
    this.fontSize = 18,
    this.isBold = false,
    this.suffix,
  });
  final bool isBold;
  final double? width, height, vPadding;
  final double? fontSize;
  final Color? color;
  final ButtonStyle? style;
  final String label;
  final VoidCallback? onPressed;
  final Widget? suffix;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style ?? buttonStyle(color: color, padding: vPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: suffix != null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          (suffix != null) ? suffix! : Container(),
          5.wSpace,
          Text(
            label.tr(),
            style: boldStyle(color: MyColors.white, size: fontSize),
          ),
        ],
      ),
    ).width(width ?? double.infinity).height(height!);
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.textColor,
    this.isBold = false,
    this.fontSize,
  });
  final double? fontSize;
  final bool isBold;
  final Color? textColor;
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          // padding: EdgeInsets.all(12),
          ),
      child: Text(
        label.tr(),
        style: labelStyle(color: textColor ?? MyColors.black, isBold: isBold, size: fontSize ?? 14),
      ),
    );
  }
}

class CustomOutLinedButton extends StatelessWidget {
  const CustomOutLinedButton({
    super.key,
    this.onPressed,
    this.label,
    this.color,
    this.radius = 8,
    this.child,
  });
  final Widget? child;
  final double radius;
  final Color? color;
  final String? label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: radius.radius,
          ),
          side: BorderSide(color: color ?? MyColors.primary, width: 1),
          padding: const EdgeInsets.symmetric(vertical: 12)),
      child: child ??
          TextTr(
            label!,
            style: boldStyle(color: color ?? MyColors.primary, size: 18),
          ).center(),
    );
  }
}

class UnderlineText extends StatelessWidget {
  const UnderlineText(this.label, {super.key, this.color, this.size, this.align, this.onTap});
  final String label;
  final Color? color;
  final VoidCallback? onTap;
  final TextAlign? align;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label.tr(),
        textAlign: align,
        style: TextStyle(color: color ?? MyColors.black, fontSize: size, decoration: TextDecoration.underline),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText(this.label, {super.key, this.color, this.size, this.align});
  final String label;
  final Color? color;
  final TextAlign? align;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: align,
      style: TextStyle(color: color ?? MyColors.black, fontSize: size),
    );
  }
}

class TextTr extends StatelessWidget {
  const TextTr(
    this.label, {
    super.key,
    this.color,
    this.size,
    this.align,
    this.style,
    this.args,
  });
  final String label;
  final Color? color;
  final TextStyle? style;
  final TextAlign? align;
  final double? size;
  final List<String>? args;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.tr(args: args),
      textAlign: align,
      style: style ?? TextStyle(color: color ?? MyColors.black, fontSize: size),
    );
  }
}
