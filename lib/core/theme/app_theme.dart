import 'package:flutter/material.dart';
import 'package:todoflutterapp/core/theme/app_color.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: AppColor.backGroundColor,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColor.appColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.appBarColor,
      ));
}
