import 'package:flutter/material.dart';
import 'package:todoflutterapp/core/theme/app_color.dart';

class RoundedElevatedButton extends StatelessWidget {
 RoundedElevatedButton({
    super.key,
    required this.buttonText,
    this.onPressed,
   this.color = AppColor.appColor,
  });

  final String buttonText;
  final Function()? onPressed;
   Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(12), // adjust radius as needed
            ),
          ),
          fixedSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 45))),
      child: Text(buttonText, style: const TextStyle(
        color: AppColor.whiteColor,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),),
    );
  }
}
