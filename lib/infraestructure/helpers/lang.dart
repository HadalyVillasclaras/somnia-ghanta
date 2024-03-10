import 'package:flutter/material.dart';
import 'package:ghanta/generated/l10n.dart';

class Lang {


  static Tr of(BuildContext context) {
    return Tr.of(context);
  }

  static String getDeviceLang(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }

  
}