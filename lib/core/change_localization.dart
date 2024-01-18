import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChangeLocalization {
  static changeLanguage(BuildContext ctx) {
    Locale? currentlocale = EasyLocalization.of(ctx)!.currentLocale;
    print(currentlocale);
    if (currentlocale == const Locale('en', 'US')) {
      EasyLocalization.of(ctx)!.setLocale(const Locale('am', 'ET'));
    } else {
      EasyLocalization.of(ctx)!.setLocale(const Locale('en', 'US'));
    }
  }
}
