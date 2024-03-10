import 'package:dio/dio.dart';
import 'package:ghanta/config/_config.dart';
import 'package:ghanta/domain/datasources/auth/auth_datasource.dart';
import 'package:ghanta/domain/entities/user.dart';
import 'package:ghanta/infraestructure/errors/_errors.dart';
import 'package:ghanta/infraestructure/mappers/user_mapper.dart';
import 'package:ghanta/infraestructure/models/responses/login_api_response.dart';

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
    // TODO: implement getUser
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

      if (user.role != Role.roleUser) {
        throw WrongCredentialsError();
      }

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
    }  catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> recoveryPassword(String email) {
    // TODO: implement recoveryPassword
    throw UnimplementedError();
  }

  @override
  Future<User> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
