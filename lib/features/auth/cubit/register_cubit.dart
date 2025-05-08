import 'package:flutter/material.dart';
import 'package:flutter_bloc/Flutter_bloc.dart';
import 'package:todoflutterapp/core/locator/locator.dart';
import 'package:todoflutterapp/data/repository/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  final AuthRepo _authRepo = locator<AuthRepo>();

  void register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    final response = await _authRepo.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );

    response.fold((failure) => emit(RegisterErrorState(error: failure.message)),
        (user) => emit(RegisterSuccessState()));
  }
}
