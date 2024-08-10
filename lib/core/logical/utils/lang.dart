import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Lang {
  static bool isEn = false;
  static String code = 'ar';
  static void updateLang(BuildContext context) {
    isEn = context.locale.languageCode.contains('en');
    code = context.locale.languageCode;
  }

  static Future<void> changeLocale(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
    final engine = WidgetsFlutterBinding.ensureInitialized();
    await engine.performReassemble();
  }}
