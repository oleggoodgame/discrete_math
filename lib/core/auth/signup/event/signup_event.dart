abstract class AuthEvent {}

class SignupPressed extends AuthEvent {
  final String email;
  final String password;

  SignupPressed(this.email, this.password);
}
