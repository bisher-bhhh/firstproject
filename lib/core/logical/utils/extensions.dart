import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import './funcs.dart';

import 'size_config.dart';

RegExp _decimalZeroPoint = RegExp(r'([.]*0)(?!.*\d)');

extension NumberExtension on num {
  double get hPercent => SizeConfig.blockSizeVertical * this;

  double get wPercent => SizeConfig.blockSizeHorizontal * this;

  Duration get duration => Duration(milliseconds: toInt());

  BorderRadius get radius => BorderRadius.circular(toDouble());

  SizedBox get wSpace => SizedBox(width: toDouble());
  SizedBox get hSpace => SizedBox(height: toDouble());
  String get toOneDecimal => toStringAsFixed(1).replaceAll(_decimalZeroPoint, '');
}

extension NotNull on Object? {
  bool get notNull => this != null;
}

extension StrEx on String? {
  bool get notNullEmpty => this != null && this!.isNotEmpty;
}

extension DateEx2 on DateTime? {
  String? get toDateOnly => this == null ? null : DateFormat('y-MM-dd', 'en').format(this!);
  DateTime? get date => this == null ? null : DateTime(this!.year, this!.month, this!.day);
  String? format([String? pattern]) => formatDateOr(this, pattern: pattern);
  String? get dateToIso => this?.toUtc().toIso8601String();
}

extension DateEx on DateTime {
  String get toDateString => DateFormat('y-MM-dd').format(this);
  String format([String? pattern]) => formatDate(this, pattern);
}

extension TimeEx on TimeOfDay {
  String get format24 => '$hour:$minute';
}

extension EnumExtension on Enum {
  String get nameTr => name.tr();
}
