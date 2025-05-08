import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/Flutter_bloc.dart';

import 'package:todoflutterapp/core/locator/locator.dart';
import 'package:todoflutterapp/data/repository/auth_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  final AuthRepo _authRepo = locator<AuthRepo>();

  void checkSession() async {
    emit(SplashLoading());

    final res = await _authRepo.checkSession();

    res.fold(
      (failure) => emit(SplashError(error: failure.message)),
      (success) => emit(SplashSuccess()),
    );
  }
}
