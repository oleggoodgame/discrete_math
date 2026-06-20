abstract class Failure implements Exception {
  final String message;
  const Failure(this.message);
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure() : super('Incorrect email or password');
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure() : super('User not found');
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('Network problem');
}

class LoadFailure extends Failure {
  const LoadFailure() : super("Couldn't load, please check connection");
}

class GraphFailure extends Failure {
  const GraphFailure() : super("There was an error with the graph.");
}

class DetourFailure extends Failure {
  const DetourFailure() : super("❌ NO MEETING POINT");
}

class ThemeFailure extends Failure {
  const ThemeFailure() : super("Theme failure");
}

class UnknowFailure extends Failure {
  const UnknowFailure(super.message);
}
