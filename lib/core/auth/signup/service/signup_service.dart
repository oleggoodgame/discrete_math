import 'package:firebase_auth/firebase_auth.dart';

class SignupService {
  void signup(String email, String password) async {
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (user.user == null) {
      throw Exception("Bad email or password, please review!");
    }
  }
}
