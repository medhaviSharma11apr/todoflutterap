import 'package:appwrite/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoflutterapp/core/locator/locator.dart';
import 'package:todoflutterapp/data/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo = locator<AuthRepo>();
  LoginCubit() : super(LoginInitial());

  void login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await _authRepo.login(email: email, password: password);

    result.fold(
        (failure) => emit(LoginFailure(
              error: failure.message,
            )),
        (session) => emit(LoginSuccess(session: session)));
  }
}
