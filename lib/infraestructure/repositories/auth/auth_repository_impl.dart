import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/domain/datasources/auth/auth_datasource.dart';
import 'package:ghanta/domain/entities/user.dart';
import 'package:ghanta/infraestructure/models/responses/_responses.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl(this._authDatasource);

  @override
  Future<User> checkAuthStatus(String token) {
    return _authDatasource.checkAuthStatus(token);
  }

  @override
  Future<User> getUser() {
    return _authDatasource.getUser();
  }

  @override
  Future<User> login(String email, String password) {
    return _authDatasource.login(email, password);
  }

  @override
  Future<void> logout(String token) {
    return _authDatasource.logout(token);
  }

  @override
  Future<UserApiResponse> updateUser(User user, String password, String token) {
    return _authDatasource.updateUser(user, password, token);
  }

  @override
  Future<String> recoveryPassword(String email) {
    return _authDatasource.recoveryPassword(email);
  }

  @override
  Future<RegisterApiResponse> register(String name, String email, String password, String passwordConfirmation) {
    return _authDatasource.register(name, email, password, passwordConfirmation);
  }

  @override
  Future<bool> verifyPassword(String email, String password) {
    return _authDatasource.verifyPassword(email, password);
  }
}
