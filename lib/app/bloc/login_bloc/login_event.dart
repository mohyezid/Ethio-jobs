part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class Loginacc extends LoginEvent {
  final String email;
  final String pass;

  Loginacc({required this.email, required this.pass});
}

class Signupacc extends LoginEvent {
  final String email;
  final Map<String, dynamic> data;
  Signupacc({required this.data, required this.email});
}

class Logout extends LoginEvent {
  Logout();
}
