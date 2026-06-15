import 'package:discrete_math/core/auth/auth/data/datasource/auth_datasource.dart';
import 'package:discrete_math/core/auth/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;
  const AuthRepositoryImpl(this.authDatasource);
  @override
  Future<bool> googleSignIn() async {
    try {
      return await authDatasource.googleSignIn();
    } catch (e) {
      return false;
    }
  }
}
