import 'package:flutter/material.dart';
import '../../logical/utils/extensions.dart';

import 'colors.dart';
import 'font_sizse.dart';
import 'package:easy_localization/easy_localization.dart';

List<BoxShadow> get getShadow => [
      BoxShadow(
        color: MyColors.primaryBlack.withOpacity(.1),
        blurRadius: 5,
        offset: const Offset(1, 6),
      )
    ];
TextStyle titleStyle({
  Color? color,
  double? size,
  bool isBold = false,
}) {
  return TextStyle(
    color: color ?? MyColors.black,
    fontSize: size ?? FontSize.xxl.toDouble(),
    fontWeight: isBold ? FontWeight.bold : null,
  );
}

TextStyle regularStyle({
  Color? color,
  double? size,
}) {
  return TextStyle(
      color: color ?? MyColors.black, fontSize: size ?? FontSize.xxl.toDouble(), fontWeight: FontWeight.w400);
}

TextStyle mediumStyle({
  Color? color,
  double? size,
}) {
  return TextStyle(
      color: color ?? MyColors.black, fontSize: size ?? FontSize.xxl.toDouble(), fontWeight: FontWeight.w500);
}

TextStyle boldStyle({
  Color? color,
  double? size,
}) {
  return TextStyle(
      color: color ?? MyColors.black, fontSize: size ?? FontSize.xxl.toDouble(), fontWeight: FontWeight.w700);
}

TextStyle infoStyle({
  Color? color,
  double? size,
  bool isBold = false,
}) {
  return TextStyle(
    color: color ?? MyColors.black,
    fontSize: size ?? FontSize.m.toDouble(),
    fontWeight: isBold ? FontWeight.bold : null,
  );
}

TextStyle sublabelStyle({
  Color? color,
  double? size,
  bool isBold = false,
}) {
  return TextStyle(
    color: color ?? MyColors.black,
    fontSize: size ?? FontSize.mx.toDouble(),
    fontWeight: isBold ? FontWeight.bold : null,
  );
}

ButtonStyle buttonStyle({Color? color, double? radius, double? padding}) {
  return ElevatedButton.styleFrom(
    backgroundColor: color ?? MyColors.primary,
    padding: EdgeInsets.symmetric(vertical: padding ?? 9),
    shape: RoundedRectangleBorder(
      borderRadius: (radius ?? 8).radius,
    ),
  );
}

TextStyle labelStyle({
  Color? color,
  double? size,
  bool isBold = false,
}) {
  return TextStyle(
    color: color ?? MyColors.black,
    fontSize: size ?? FontSize.l.toDouble(),
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  );
}

InputDecoration getFieldDecoration({
  String? hint,
  Widget? suffixIcon,
  double? hPadding,
  double radius = 8,
  bool filled = true,
}) {
  InputBorder inputBorder() => OutlineInputBorder(
        borderRadius: radius.radius,
        borderSide: const BorderSide(width: 0, color: MyColors.lightGrey),
      );

  InputBorder errorBorder() => OutlineInputBorder(
        borderRadius: radius.radius,
        borderSide: const BorderSide(color: Colors.red),
      );
  return InputDecoration(
    hintText: hint?.tr(),
    hintStyle: regularStyle(color: const Color(0xFFE4E4E4), size: 12),
    fillColor: Colors.transparent,
    filled: filled,
    border: inputBorder(),
    enabledBorder: inputBorder(),
    focusedBorder: inputBorder(),
    disabledBorder: inputBorder(),
    errorBorder: errorBorder(),
    focusedErrorBorder: errorBorder(),
    suffixIcon: suffixIcon,
    isDense: false,
    isCollapsed: true,
    contentPadding: EdgeInsets.symmetric(
      horizontal: hPadding ?? 12,
      vertical: 11,
    ),
  );
}

final timePickerTheme = TimePickerThemeData(
  backgroundColor: Colors.blueGrey,
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Colors.orange, width: 4),
  ),
  dayPeriodBorderSide: const BorderSide(color: Colors.orange, width: 4),
  dayPeriodColor: Colors.blueGrey.shade600,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Colors.orange, width: 4),
  ),
  dayPeriodTextColor: MyColors.black,
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Colors.orange, width: 4),
  ),
  hourMinuteColor: WidgetStateColor.resolveWith(
      (states) => states.contains(WidgetState.selected) ? Colors.orange : Colors.blueGrey.shade800),
  hourMinuteTextColor: WidgetStateColor.resolveWith(
      (states) => states.contains(WidgetState.selected) ? MyColors.black : Colors.orange),
  dialHandColor: Colors.blueGrey.shade700,
  dialBackgroundColor: Colors.blueGrey.shade800,
  hourMinuteTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  dayPeriodTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  helpTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: MyColors.black),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: WidgetStateColor.resolveWith(
      (states) => states.contains(WidgetState.selected) ? Colors.orange : MyColors.black),
  entryModeIconColor: Colors.orange,
);
