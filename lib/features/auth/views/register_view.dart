import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoflutterapp/core/theme/app_color.dart';
import 'package:todoflutterapp/core/utils/validation_rules.dart';
import 'package:todoflutterapp/core/widgets/custom_text_form_field.dart';
import 'package:todoflutterapp/core/widgets/rounded_elevated_button.dart';
import 'package:todoflutterapp/features/auth/cubit/register_cubit.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
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
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
            },
            builder: (context, state) {
              return Form(
                  key: _registerFormKey,
                  child: Column(
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
                        controller: _firstNameController,
                        validator: ((val) {
                          if (val!.isEmpty) {
                            return "Value is required*";
                          } else {
                            return null;
                          }
                        }),
                        keyboardtype: TextInputType.name,
                        obscureText: false,
                        hintText: "First Name",
                        suffix: null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        controller: _lastNameController,
                        validator: ((val) {
                          if (val!.isEmpty) {
                            return "Value is required*";
                          } else {
                            return null;
                          }
                        }),
                        keyboardtype: TextInputType.name,
                        obscureText: false,
                        hintText: "Last Name",
                        suffix: null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        validator: ((val) {
                          if (val!.isEmpty) {
                            return "Value is required*";
                          } else if (!ValidationRules.emailValidation
                              .hasMatch(val)) {
                            return "Provide a valid email";
                          } else {
                            return null;
                          }
                        }),
                        keyboardtype: TextInputType.emailAddress,
                        obscureText: false,
                        hintText: "Email",
                        suffix: null,
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
                        hintText: "password",
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
                        buttonText: "Register",
                        onPressed: () {
                          if (_registerFormKey.currentState!.validate()) {}
                        },
                      )
                    ],
                  ));
            },
          ),
        ),
      )),
    );
  }
}
