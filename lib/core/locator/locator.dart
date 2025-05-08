import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todoflutterapp/core/utils/storage_service.dart';
import 'package:todoflutterapp/data/provider/appwrite_provider.dart';

import '../../data/repository/auth_repository.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<AppWriteProvider>((() => AppWriteProvider()));
  locator.registerLazySingleton<AuthRepo>((() => AuthRepo()));
  locator.registerLazySingleton<StorageService>((() => StorageService()));
  locator.registerLazySingleton<InternetConnectionChecker>(
      (() => InternetConnectionChecker()));
}
