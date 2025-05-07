import 'package:flutter/material.dart';

import '../../../core/utils/app_image_url.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
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
