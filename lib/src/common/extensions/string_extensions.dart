import 'package:flutter/material.dart';
import 'package:movie_app_clean_code/src/presentation/app_localization.dart';

extension StringExtension on String {
  String get trimToFixedString {
    return length > 14 ? '${substring(0, 14)}...' : this;
  }

  String t(BuildContext context) {
    return AppLocalization.of(context).translate(this);
  }
}
