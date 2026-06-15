part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginPressed extends AuthEvent {
  final String email;
  final String password;

  LoginPressed(this.email, this.password);
}

class LogoutPressed extends AuthEvent {}

class SignupPressed extends AuthEvent {
  final String email;
  final String password;

  SignupPressed(this.email, this.password);
}

class GoogleStart extends AuthEvent {
  GoogleStart();
}