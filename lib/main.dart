import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoflutterapp/core/locator/locator.dart';
import 'package:todoflutterapp/core/routes/routes.dart';
import 'package:todoflutterapp/core/theme/app_theme.dart';
import 'package:todoflutterapp/features/auth/cubit/login_cubit.dart';

import 'features/auth/cubit/register_cubit.dart';
import 'features/spalsh/cubit/splash_cubit.dart';
import 'features/todo/cubit/todo_cubit.dart';

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => RegisterCubit(),
      ),
      BlocProvider(
        create: (_) => LoginCubit(),
      ),
      BlocProvider(
        create: (_) => SplashCubit(),
      ),
      BlocProvider(
        create: (_) => TodoCubit(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      routerConfig: router,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
