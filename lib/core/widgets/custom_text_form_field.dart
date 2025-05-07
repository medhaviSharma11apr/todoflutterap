import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todoflutterapp/core/theme/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String? val) validator;
  final TextInputType keyboardtype;
  final bool obscureText;
  final String hintText;
  final Widget? suffix;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.validator,
      required this.keyboardtype,
      required this.obscureText,
      required this.hintText,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        keyboardType: keyboardtype,
        obscureText: obscureText,
        style: Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffix,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColor.borderColor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColor.borderColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.appColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColor.errorColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColor.errorColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          errorStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColor.errorColor,
                fontSize: 12,
              ),
        ));
  }
}
