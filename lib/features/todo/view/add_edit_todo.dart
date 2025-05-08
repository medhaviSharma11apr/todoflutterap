import 'package:flutter/material.dart';
import 'package:todoflutterapp/core/widgets/custom_text_form_field.dart';
import 'package:todoflutterapp/core/widgets/rounded_elevated_button.dart';

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
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo"), actions: const []),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Form(
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
              )),
        ),
      ),
    );
  }
}
