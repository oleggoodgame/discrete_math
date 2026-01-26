import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  void login(String email, String password) async {
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (user.user == null) {
      throw Exception("Bad email or password, please review!");
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
