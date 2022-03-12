part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class LoginLoading extends UserState {}

class LoginSuccessfully extends UserState {
}

class LoginError extends UserState {
  final String message;

  LoginError(this.message);

}

class OtpSuccessfully extends UserState {
  final String code;

  OtpSuccessfully(this.code);

}