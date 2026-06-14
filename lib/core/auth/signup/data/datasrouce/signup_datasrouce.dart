import 'package:firebase_auth/firebase_auth.dart';

abstract class SignupDatasrouce {
  Future<void> signup(String email, String password);
}

class SignupDatasrouceImpl implements SignupDatasrouce {
  @override
  Future<void> signup(String email, String password) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    if (credential.user == null) {
      throw FirebaseAuthException(
        code: 'unknown',
        message: 'Registration failed',
      );
    }
  }
}
