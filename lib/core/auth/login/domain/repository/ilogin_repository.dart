abstract class LoginRepostiory {
  Future<void> login(String email, String password);
  Future<void> logout();
}
