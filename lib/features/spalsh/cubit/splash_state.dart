part of 'splash_cubit.dart';

@immutable
class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashSuccess extends SplashState {
  bool ifUser;
  SplashSuccess({this.ifUser = true});
}

class SplashError extends SplashState {
  final String error;
  SplashError({required this.error});
}
