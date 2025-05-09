part of 'todo_cubit.dart';

@immutable
class TodoState {}

class TodoInitial extends TodoState {}

class TodoAddEditDeleteLoading extends TodoState {}

class TodoFetchLoading extends TodoState {}

class TodoAddEditDeleteSuccess extends TodoState {}

class TodoFetchSuccess extends TodoState {
  final List<TodoModel> todos;

  TodoFetchSuccess({
    required this.todos,
  });
}

class TodoAddError extends TodoState {
  String error;
  TodoAddError({
    required this.error,
  });

}

