import 'package:discrete_math/core/auth/signup/data/datasrouce/signup_datasrouce.dart';
import 'package:discrete_math/core/auth/signup/domain/repostiory/signup_repostiory.dart';
import 'package:discrete_math/shared/errors/error.dart';

class SignupRepositoryImpl implements SignupRepostiory {
  final SignupDatasrouce signupDatasrouce;
  const SignupRepositoryImpl(this.signupDatasrouce);
  @override
  Future<void> signup(String email, String password) async {
    try {
      await signupDatasrouce.signup(email, password);
    } catch (e) {
      throw const InvalidCredentialsFailure();
      
    }
  }
}
