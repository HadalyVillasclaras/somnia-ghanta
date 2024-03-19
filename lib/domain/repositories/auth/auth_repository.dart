import 'package:ghanta/domain/entities/user.dart';
import 'package:ghanta/infraestructure/models/responses/register_api_response.dart';

abstract class AuthRepository {

  Future<User> login(String email, String password);

  Future<RegisterApiResponse> register(String name, String email, String password, String passwordConfirmation);

  Future<User> checkAuthStatus(String token);

  Future<String> recoveryPassword(String email);

  Future<User> getUser();

  Future<void> logout(String token);

  Future<bool> verifyPassword(String email, String password);

}