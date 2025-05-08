import 'package:go_router/go_router.dart';
import 'package:todoflutterapp/core/routes/route_name.dart';
import 'package:todoflutterapp/features/auth/views/login_view.dart';
import 'package:todoflutterapp/features/auth/views/register_view.dart';
import 'package:todoflutterapp/features/todo/view/todo_view.dart';

import '../../features/spalsh/view/spalsh_view.dart';
import '../../features/todo/view/add_edit_todo.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    name: RouteNames.splash,
    path: '/',
    builder: (context, state) => const SplashView(),
  ),
  GoRoute(
    name: RouteNames.register,
    path: '/register',
    builder: (context, state) => const RegisterView(),
  ),
  GoRoute(
    name: RouteNames.login,
    path: '/login',
    builder: (context, state) => const LoginView(),
  ),
  GoRoute(
    name: RouteNames.todo,
    path: '/todo',
    builder: (context, state) => const ToDoView(),
  ),

  GoRoute(
    name: RouteNames.addTodo,
    path: '/addTodo',
    builder: (context, state) => const AddEditTodoView(),
  ),
]);
