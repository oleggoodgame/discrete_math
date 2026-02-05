import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  Future<User> login(String email, String password) async {
    final credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw FirebaseAuthException(
        code: 'unknown',
        message: 'Bad email or password',
      );
    }

    return credential.user!;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

