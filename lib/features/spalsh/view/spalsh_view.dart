import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoflutterapp/core/routes/route_name.dart';

import '../../../core/utils/app_image_url.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    print("Navigating to login...");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.goNamed(RouteNames.login);
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImageUrl.logo,
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
