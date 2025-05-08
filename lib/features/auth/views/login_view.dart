import 'package:flutter/material.dart';
import 'package:flutter_bloc/Flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoflutterapp/core/routes/route_name.dart';
import 'package:todoflutterapp/core/theme/app_color.dart';
import 'package:todoflutterapp/core/utils/custom_snackbar.dart';
import 'package:todoflutterapp/core/utils/full_screen_dialouge_loader.dart';
import 'package:todoflutterapp/core/utils/storage_key.dart';
import 'package:todoflutterapp/core/utils/storage_service.dart';
import 'package:todoflutterapp/core/utils/validation_rules.dart';
import 'package:todoflutterapp/core/widgets/custom_text_form_field.dart';
import 'package:todoflutterapp/core/widgets/rounded_elevated_button.dart';
import 'package:todoflutterapp/features/auth/cubit/login_cubit.dart';

import '../../../core/locator/locator.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginformKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;
  final StorageService _storageService = locator<StorageService>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void clearText() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginLoading) {
                  FullScreenDialougeLoader.show(context);
                } else if (state is LoginSuccess) {
                  FullScreenDialougeLoader.cancel(context);
                  CustomSnackBar.showSuccess(context, "Login Successfully");
                  _storageService.setValue(
                      StorageKey.userId, state.session.userId);
                  _storageService.setValue(
                      StorageKey.sessionId, state.session.$id);
                  clearText();
                  context.goNamed(RouteNames.todo);
                } else if (state is LoginFailure) {
                  FullScreenDialougeLoader.cancel(context);
                  CustomSnackBar.showError(context, state.error);
                }
              },
              child: Form(
                key: _loginformKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        validator: ((val) {
                          if (val!.isEmpty) {
                            return "Value is required*";
                          } else if (!ValidationRules.emailValidation
                              .hasMatch(val)) {
                            return "Invalid Email";
                          } else {
                            return null;
                          }
                        }),
                        keyboardtype: TextInputType.emailAddress,
                        obscureText: false,
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        controller: _passwordController,
                        validator: ((val) {
                          if (val!.isEmpty) {
                            return "Value is required*";
                          } else {
                            return null;
                          }
                        }),
                        keyboardtype: TextInputType.visiblePassword,
                        obscureText: !isPasswordVisible,
                        hintText: 'Password',
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColor.greyColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RoundedElevatedButton(
                        buttonText: "Login",
                        onPressed: () {
                          if (_loginformKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(
                                email: _emailController.text,
                                password: _passwordController.text);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.goNamed(
                            RouteNames.register,
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                  color: AppColor.greyColor, fontSize: 16),
                              children: [
                                TextSpan(
                                    text: 'Register',
                                    style: TextStyle(
                                      color: AppColor.appColor,
                                      fontWeight: FontWeight.w500,
                                    ))
                              ]),
                        ),
                      )
                    ]),
              ),
            )),
      )),
    );
  }
}
