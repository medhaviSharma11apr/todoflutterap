import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:todoflutterapp/core/theme/app_color.dart';

class FullScreenDialougeLoader1 extends StatefulWidget {
  const FullScreenDialougeLoader1({super.key});

  @override
  State<FullScreenDialougeLoader1> createState() =>
      _FullScreenDialougeLoaderState();
}

class _FullScreenDialougeLoaderState extends State<FullScreenDialougeLoader1> {
  static bool _isialougeOpen = false;
  @override
  Widget build(BuildContext context) {
    if (!_isialougeOpen) {
      _isialougeOpen = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // if (context.mounted) {
        showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: AppColor.transparentColor,
            builder: ((context) {
              return WillPopScope(
                  onWillPop: () async => false,
                  child: const Center(
                    child: SpinKitCircle(
                      color: AppColor.appColor,
                    ),
                  ));
            })).then((value) {
          _isialougeOpen = false;
        });
        // }
      });
    }
    return Container();
  }
}

class FullScreenDialougeLoader {
  static bool _isialougeOpen = false;

  static void show(BuildContext context) {
    if (!_isialougeOpen) {
      _isialougeOpen = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // if (context.mounted) {
        showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: AppColor.transparentColor,
            builder: ((context) {
              return WillPopScope(
                  onWillPop: () async => false,
                  child: const Center(
                    child: SpinKitCircle(
                      color: AppColor.appColor,
                    ),
                  ));
            })).then((value) {
          _isialougeOpen = false;
        });
        // }
      });
    }
  }

  static void cancel(BuildContext context) {
    if (_isialougeOpen) {
      Navigator.of(context, rootNavigator: false).pop();
      _isialougeOpen = false;
    }
  }
  static bool isDialougeOpen(){
    return _isialougeOpen;
  }
}
