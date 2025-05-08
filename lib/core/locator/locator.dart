// import 'package:get_it/get_it.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:todoflutterapp/data/provider/appwrite_provider.dart';

// import '../../data/repository/auth_repository.dart';

// final locator = GetIt.instance;

// void setUpLocator() {
//   locator.registerLazySingleton<AppWriteProvider>((() => AppWriteProvider()));
//   locator.registerLazySingleton<AuthRepo>((() => AuthRepo()));
//   locator.registerLazySingleton<InternetConnectionChecker>(
//       (() => InternetConnectionChecker()));
// }


import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todoflutterapp/data/provider/appwrite_provider.dart';
import 'package:todoflutterapp/data/repository/auth_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AppWriteProvider>(() => AppWriteProvider());
  locator.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  locator.registerLazySingleton<IAuthRepository>(() => AuthRepo());
}

