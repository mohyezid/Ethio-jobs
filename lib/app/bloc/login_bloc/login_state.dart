part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LogInSuccess extends LoginState {
  final ProfileState pdata;
  LogInSuccess({required this.pdata});
}

class LogInFailed extends LoginState {
  final String error;
  LogInFailed({required this.error});
}
