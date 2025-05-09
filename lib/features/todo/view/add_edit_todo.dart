import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/Flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoflutterapp/core/routes/route_name.dart';
import 'package:todoflutterapp/core/utils/custom_snackbar.dart';
import 'package:todoflutterapp/core/utils/full_screen_dialouge_loader.dart';
import 'package:todoflutterapp/core/widgets/custom_text_form_field.dart';
import 'package:todoflutterapp/core/widgets/rounded_elevated_button.dart';

import '../cubit/todo_cubit.dart';

class AddEditTodoView extends StatefulWidget {
  const AddEditTodoView({super.key});

  @override
  State<AddEditTodoView> createState() => _AddEditTodoViewState();
}

class _AddEditTodoViewState extends State<AddEditTodoView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleEditingController,
      _descriptionEditingController;
  late bool isCompleted;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleEditingController = TextEditingController();
    _descriptionEditingController = TextEditingController();
    isCompleted = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleEditingController.dispose();
    _descriptionEditingController.dispose();
  }

  clearText() {
    _titleEditingController.clear();
    _descriptionEditingController.clear();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final title = _titleEditingController.text;
      final description = _descriptionEditingController.text;
      log('title${_titleEditingController.text}');
      log('description${_descriptionEditingController.text}');
      context.read<TodoCubit>().addTodo(
            title: title,
            description: description,
            isCompleted: false,
          );
      clearText();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo"), actions: const []),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: BlocConsumer<TodoCubit, TodoState>(
            listener: (context, state) {
              if (state is TodoAddEditDeleteLoading) {
                FullScreenDialougeLoader.show(context);
              } else if (state is TodoAddEditDeleteSuccess) {
                FullScreenDialougeLoader.cancel(context);
                CustomSnackBar.showSuccess(context, "Todo Added Successfully");
                context.goNamed(RouteNames.todo);
              } else if (state is TodoAddError) {
                FullScreenDialougeLoader.cancel(context);
                CustomSnackBar.showError(context, state.error);
              }
            },
            builder: (context, state) {
              return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _titleEditingController,
                        validator: ((val) {
                          if (!val!.isNotEmpty) {
                            return "Title is required *";
                          } else {
                            return null;
                          }
                        }),
                        keyboardtype: TextInputType.text,
                        hintText: "Title",
                        obscureText: false,
                        suffix: null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        controller: _descriptionEditingController,
                        validator: ((val) {
                          if (!val!.isNotEmpty) {
                            return "Description is required *";
                          } else {
                            return null;
                          }
                        }),
                        keyboardtype: TextInputType.text,
                        hintText: "Description",
                        obscureText: false,
                        suffix: null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RoundedElevatedButton(
                          buttonText: 'Add Todo',
                          onPressed: () {
                            _submit();
                          })
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
