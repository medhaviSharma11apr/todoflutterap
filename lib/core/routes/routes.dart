import 'package:go_router/go_router.dart';
import 'package:todoflutterapp/core/routes/route_name.dart';

final GoRouter router = GoRouter(routes:[
  GoRoute(name: RouteNames.splash,path: '/',
   builder: (context, state) => const SplashView(),
  ),
] );