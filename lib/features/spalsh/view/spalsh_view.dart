import 'package:flutter/material.dart';
import 'package:flutter_bloc/Flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoflutterapp/core/routes/route_name.dart';
import 'package:todoflutterapp/core/utils/custom_snackbar.dart';
import 'package:todoflutterapp/core/utils/full_screen_dialouge_loader.dart';
import 'package:todoflutterapp/features/spalsh/cubit/splash_cubit.dart';

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
      context.read<SplashCubit>().checkSession();
      // context.goNamed(RouteNames.login);
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashLoading) {
              FullScreenDialougeLoader.show(context);
              // context.goNamed(RouteNames.login);
            } else if (state is SplashSuccess) {
              FullScreenDialougeLoader.cancel(context);
              context.goNamed(RouteNames.todo);
            } else if (state is SplashError) {
              FullScreenDialougeLoader.cancel(context);
              context.goNamed(RouteNames.login);
              CustomSnackBar.showError(context, state.error);
            }
          },
          builder: (context, state) {
            return Image.asset(
              AppImageUrl.logo,
              width: 80,
              height: 80,
            );
          },
        ),
      ),
    );
  }
}
