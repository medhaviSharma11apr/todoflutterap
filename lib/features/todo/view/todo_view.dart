import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoflutterapp/core/routes/route_name.dart';
import 'package:todoflutterapp/core/theme/app_color.dart';
import 'package:todoflutterapp/core/utils/full_screen_dialouge_loader.dart';
import 'package:todoflutterapp/features/todo/cubit/todo_cubit.dart';

class ToDoView extends StatefulWidget {
  const ToDoView({super.key});

  @override
  State<ToDoView> createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
  @override
  void initState() {
    super.initState();
    context.read<TodoCubit>().getTodo();
  }

  delete({required String documentId}) {
    log('id$documentId');

    context.read<TodoCubit>().deleteTodo(
          documentId: documentId,
        );
    context.goNamed(RouteNames.todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do App'),
        actions: [
          IconButton(
            onPressed: () {
              // move to profile section
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoAddEditDeleteLoading) {
            FullScreenDialougeLoader.show(context);
          } else if (state is TodoFetchSuccess) {
            final todo = state.todos;

            FullScreenDialougeLoader.cancel(context);

            return todo.isNotEmpty
                ? ListView.builder(
                    itemCount: todo.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        title: Text(todo[index].title),
                        subtitle: Text(todo[index].description),
                        leading: CircleAvatar(
                          radius: 10,
                          backgroundColor: todo[index].isCompleted
                              ? Colors.green
                              : Colors.red,
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: (() {
                                    context.goNamed(
                                      RouteNames.editTodo,
                                      extra: todo[index],
                                    );
                                  }),
                                  icon: const Icon(Icons.edit)),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: (() {
                                    delete(documentId: todo[index].id);
                                  }),
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      );
                    }))
                : Container(
                    child: const Text('no data '),
                  );
          } else if (state is TodoAddError) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(RouteNames.addTodo);
        },
        backgroundColor: AppColor.appColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
