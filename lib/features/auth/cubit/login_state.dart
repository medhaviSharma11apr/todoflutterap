part of 'login_cubit.dart';

@immutable
class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Session session;
  LoginSuccess({required this.session});
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure({required this.error});
}
