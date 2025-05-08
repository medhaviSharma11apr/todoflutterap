import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoflutterapp/core/routes/route_name.dart';
import 'package:todoflutterapp/core/theme/app_color.dart';
import 'package:todoflutterapp/core/utils/validation_rules.dart';
import 'package:todoflutterapp/core/widgets/custom_text_form_field.dart';
import 'package:todoflutterapp/core/widgets/rounded_elevated_button.dart';

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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                        if (_loginformKey.currentState!.validate()) {}
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
            )),
      )),
    );
  }
}
