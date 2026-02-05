import 'package:firebase_auth/firebase_auth.dart';

class SignupService {
  Future<User> signup(String email, String password) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw FirebaseAuthException(
        code: 'unknown',
        message: 'Registration failed',
      );
    }

    return credential.user!;
  }
}