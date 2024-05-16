import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ghanta/config/_config.dart';
import 'package:ghanta/domain/datasources/auth/auth_datasource.dart';
import 'package:ghanta/domain/entities/user.dart';
import 'package:ghanta/infraestructure/errors/_errors.dart';
import 'package:ghanta/infraestructure/mappers/user_mapper.dart';
import 'package:ghanta/infraestructure/models/responses/login_api_response.dart';
import 'package:ghanta/infraestructure/models/responses/register_api_response.dart';
import 'package:ghanta/infraestructure/models/responses/user_update_response.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await ApiConfig.dio.get('/me',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));

      final user = UserMapper()
          .userApiToEntity(LoginApiResponse.fromJson(response.data));

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 403 ||
          e.response?.statusCode == 400) {
        throw UnauthenticatedError();
      }

      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getUser() {
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
      });

      final response = await ApiConfig.dio.post('/login',
          data: formData, options: Options(contentType: 'multipart/form-data'));

      final user = UserMapper()
          .userApiToEntity(LoginApiResponse.fromJson(response.data));

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 403 ||
          e.response?.statusCode == 400) {
        throw WrongCredentialsError();
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout(String token) async {
    try {
      await ApiConfig.dio.post('/logout',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 403 ||
          e.response?.statusCode == 400) {
        throw WrongCredentialsError();
      }

      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> recoveryPassword(String email) {
    throw UnimplementedError();
  }

  @override
  Future<RegisterApiResponse> register(String name, String email,
      String password, String passwordConfirmation) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'role': 'ROLE_USER'
      });

      final response = await ApiConfig.dio.post('/register',
          data: formData, options: Options(contentType: 'multipart/form-data'));

      final registerResponse = RegisterApiResponse.fromJson(response.data);

      return registerResponse;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 403 ||
          e.response?.statusCode == 400) {
        final errors = e.response?.data['errors'];
        final emailErrors = errors?['email'];

        if (emailErrors is List &&
            emailErrors.contains("The email has already been taken.")) {
          throw CustomError('El email que has introducido ya existe.', 400);
        }

        throw WrongCredentialsError();
      }

      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserApiResponse> updateUser(User user, String password, String token) async {
    try {
      final jsonData = {
        'name': user.name,
        'email': user.email,
        'password': password,
        'role': User.roleToApiString(user.role),
        'status': User.statusToApiString(user.status),
      };

      final response = await ApiConfig.dio.put(
        '/users/${user.id}',
        data: jsonEncode(jsonData),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      final updateResponse = UserApiResponse.fromJson(response.data);
      return updateResponse;

    } on DioException catch (e) {
      if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 403 ||
          e.response?.statusCode == 400) {
        throw Exception('Ha habido un error con la autenticación');
      } else {
        throw Exception('Se ha producido un error y la contraseña no ha podido ser modificada.');
      }
    } catch (e) {
      throw Exception('Ha habido un error en el sistema.');
    }
  }

  // I have faked the verifyPassword with the login service. This is a workaround because there is no verifyPassword service in the API
  @override
  Future<bool> verifyPassword(String email, String password) async {
    var isValidPassword = false;

    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
      });

      final response = await ApiConfig.dio.post('/login',
          data: formData, options: Options(contentType: 'multipart/form-data'));

      if (response.statusCode == 200) {
        isValidPassword = true;
      }
      return isValidPassword;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 403 ||
          e.response?.statusCode == 400) {
        throw WrongCredentialsError();
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
