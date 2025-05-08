import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todoflutterapp/data/provider/appwrite_provider.dart';

import '../../data/repository/auth_repository.dart';

final locator = GetIt.I;

void setUpLocator() {
  locator.registerLazySingleton<InternetConnectionChecker>(
      (() => InternetConnectionChecker()));
        locator.registerLazySingleton<AppWriteProvider>(
      (() => AppWriteProvider()));
         locator.registerLazySingleton<AuthRepo>((() => AuthRepo()));
}

