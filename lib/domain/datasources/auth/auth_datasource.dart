import 'package:ghanta/domain/entities/user.dart';
import 'package:ghanta/infraestructure/models/responses/_responses.dart';

abstract class AuthDatasource {

  Future<User> login(String email, String password);

  Future<RegisterApiResponse> register(String name, String email, String password, String passwordConfirmation);

  Future<User> checkAuthStatus(String token);

  Future<String> recoveryPassword(String email);

  Future<User> getUser();

  Future<void> logout(String token);

  Future<UserApiResponse> updateUser(User user, String password, String token);

  Future<bool> verifyPassword(String email, String password);
}