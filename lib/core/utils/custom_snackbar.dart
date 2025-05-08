import 'package:flutter/material.dart';
import 'package:todoflutterapp/core/theme/app_color.dart';

class CustomSnackBar {
  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(context, message, AppColor.snackBarGreen);
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackBar(context, message, AppColor.snackBarBlue);
  }

  static void showError(BuildContext context, String message) {
    _showSnackBar(context, message, AppColor.snackBarRed);
  }

  static void _showSnackBar(BuildContext context, String message, Color color) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColor.whiteColor,
        ),
        ),
        
        backgroundColor: color,)
      );
    });
  }
}
