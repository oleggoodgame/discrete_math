import 'package:discrete_math/core/auth/login/data/datasource/login_firebase_datasource.dart';
import 'package:discrete_math/core/auth/login/domain/repository/ilogin_repository.dart';
import 'package:discrete_math/shared/errors/error.dart';

class LoginRepositoryImpl implements LoginRepostiory {
  final LoginDatasource loginDatasource;
  const LoginRepositoryImpl(this.loginDatasource);
  @override
  Future<void> login(String email, String password) async {
    try {
      await loginDatasource.login(email, password);
    } catch (e) {
      throw const InvalidCredentialsFailure();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await loginDatasource.logout();
    } catch (e) {
      throw const InvalidCredentialsFailure();
    }
  }
}
