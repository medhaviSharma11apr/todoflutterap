import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoflutterapp/core/utils/storage_key.dart';
import 'package:todoflutterapp/core/utils/storage_service.dart';
import 'package:todoflutterapp/data/repository/todo_repository.dart';

import '../../../core/locator/locator.dart';
import '../../../data/model/todo_model.dart';
import '../../../data/repository/auth_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final AuthRepo _authRepo = locator<AuthRepo>();

  final TodoRepository _todoRepository = locator<TodoRepository>();

  final StorageService _storageService = locator<StorageService>();

  TodoCubit() : super(TodoInitial());

  void addTodo({
    required String title,
    required String description,
    required bool isCompleted,
  }) async {
    emit(TodoAddEditDeleteLoading());
    final res = await _todoRepository.addTodos(
      title: title,
      description: description,
      isCompleted: isCompleted,
      userId: _storageService.getValue(StorageKey.userId),
    );
    res.fold(
      (l) => emit(TodoAddError(error: l.message)),
      (doc) => emit(TodoAddEditDeleteSuccess()),
    );
  }

  void getTodo() async {
    emit(TodoAddEditDeleteLoading());
    final res = await _todoRepository.getTodo(
        userId: _storageService.getValue(StorageKey.userId));

    res.fold((l) => emit(TodoAddError(error: l.message)),
        (todo) => emit(TodoFetchSuccess(todos: todo)));
  }

  void editTodo({
    required String title,
    required String description,
    required bool isCompleted,
    required String documentId,
  }) async {
    emit(TodoAddEditDeleteLoading());
    final res = await _todoRepository.editTodos(
      title: title,
      description: description,
      isCompleted: isCompleted,
      documentId: documentId,
    );
    res.fold(
      (l) => emit(TodoAddError(error: l.message)),
      (doc) => emit(TodoAddEditDeleteSuccess()),
    );
  }

  void deleteTodo({required String documentId}) async {
    emit(TodoAddEditDeleteLoading());

    final res = await _todoRepository.deleteTodo(documentId: documentId);
    log('res$res');
    res.fold((l) => emit(TodoAddError(error: l.message)),
        (r) => emit(TodoAddEditDeleteSuccess()));
  }
}
