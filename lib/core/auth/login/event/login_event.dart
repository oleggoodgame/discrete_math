abstract class AuthEvent {}

class LoginPressed extends AuthEvent {
  final String email;
  final String password;

  LoginPressed(this.email, this.password);
}

class LogoutPressed extends AuthEvent {}
