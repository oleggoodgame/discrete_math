import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginDatasource {
  Future<void> login(String email, String password);
  Future<void> logout();
}

class LoginDatasourceImpl  implements LoginDatasource {
  @override
  Future<void> login(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw FirebaseAuthException(
        code: 'unknown',
        message: 'Bad email or password',
      );
    }
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
