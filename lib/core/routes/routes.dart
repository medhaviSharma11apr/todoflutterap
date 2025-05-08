import 'package:go_router/go_router.dart';
import 'package:todoflutterapp/core/routes/route_name.dart';
import 'package:todoflutterapp/features/auth/views/login_view.dart';
import 'package:todoflutterapp/features/auth/views/register_view.dart';

import '../../features/spalsh/view/spalsh_view.dart';

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
]);
