import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/domain/entities/user.dart';
import 'package:ghanta/infraestructure/datasources/auth/auth_datasource_impl.dart';
import 'package:ghanta/infraestructure/errors/_errors.dart';
import 'package:ghanta/infraestructure/repositories/auth/auth_repository_impl.dart';
import 'package:ghanta/infraestructure/services/key_value_storage_service.dart';
import 'package:ghanta/infraestructure/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepositoryImpl = AuthRepositoryImpl(AuthDatasourceImpl());
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
      authRepository: authRepositoryImpl,
      keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier(
      {required this.authRepository, required this.keyValueStorageService})
      : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on WrongCredentialsError {
      logout(errorMessage: 'Credenciales incorrectas');
      state = state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          errorMessage: 'Credenciales incorrectas');
    } catch (e) {
      logout(errorMessage: 'Ha ocurrido un error');
    }
  }

  Future<bool> verifyPassword(String password) async {
    try {
      final user = state.user;
      if (user == null) return false;
      final isValidPass =
          await authRepository.verifyPassword(user.email, password);
      return isValidPass;
    } on WrongCredentialsError {
      state = state.copyWith(errorMessage: 'El password no es válido.');
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> registerUser(String name, String email, String password,
      String passwordConfirmation) async {
    try {
      final registerResponse = await authRepository.register(
          name, email, password, passwordConfirmation);

      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        user: User(
            id: registerResponse.id,
            name: registerResponse.name,
            email: registerResponse.email,
            role: registerResponse.role,
            status: Status.inactive,
            token: registerResponse.authorization.token),
        errorMessage: null,
      );
    } on WrongCredentialsError {
      state = state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          errorMessage: 'Credenciales incorrectas');
    } on CustomError catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        user: null,
        errorMessage: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        user: null,
        errorMessage: 'Ha ocurrido un error inesperado',
      );
    }
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');
    if (token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } on WrongCredentialsError {
      logout(errorMessage: 'Credenciales incorrectas');
    } on UnauthenticatedError {
      logout(errorMessage: 'Sesión expirada');
    } catch (e) {
      logout(errorMessage: 'Ha ocurrido un error');
    }
  }

  Future<void> logout({String? errorMessage}) async {
    final String token =
        await keyValueStorageService.getValue<String>('token') ?? '';

    if (token.isNotEmpty) {
      try {
        await authRepository.logout(token);
      } on WrongCredentialsError {
        await keyValueStorageService.removeKey('token');
      } catch (e) {
        debugPrint('Error setting audio source: $e');
      }
    }

    await keyValueStorageService.removeKey(token);
    await keyValueStorageService.removeKey('token');
    await keyValueStorageService.removeKey('user');

    state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        user: null,
        errorMessage: errorMessage ?? '');
  }

  void _setLoggedUser(User user) async {
    await keyValueStorageService.setKeyValue<String>('token', user.token ?? '');
    // await keyValueStorageService.setKeyValue<String>('user', jsonEncode(user.toJson()));

    state = state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: user,
        errorMessage: 'Bienvenido a Ghanta');
  }

  Future<bool> updateUser (
    int id, 
    String name, 
    String email, 
    String password
  ) async {
    final String token =
        await keyValueStorageService.getValue<String>('token') ?? '';

    if (token.isNotEmpty) {
      try {
        final user = User(
          id: id,
          name: name,
          email: email,
          role: User.roleFromJson('ROLE_USER'),
          status: User.statusFromJson('ACTIVE'),
        );

        final updateResponse =
            await authRepository.updateUser(user, password, token);

        state = state.copyWith(
          user: User(
            id: updateResponse.user.id,
            name: updateResponse.user.name,
            email: updateResponse.user.email,
            role: updateResponse.user.role,
            status: updateResponse.user.status,
          ),
          errorMessage: '',
        );

        return true;
      } on DioException catch (e) {
        String errorMessage =
            'Se ha producido un error y la contraseña no ha podido ser modificada.';
        if (e.response?.statusCode == 401 ||
            e.response?.statusCode == 403 ||
            e.response?.statusCode == 400) {
          errorMessage = 'Ha habido un error con la autenticación';
        }
        state = state.copyWith(errorMessage: errorMessage);
        return false;
      } catch (e) {
        state =
            state.copyWith(errorMessage: 'Se ha producido un error. Por favor, inténtelo más tarde.');
        return false;
      }
    }
    return false;
  }
}

// --------- Estado
enum AuthStatus { checking, authenticated, unauthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith(
          {AuthStatus? authStatus, User? user, String? errorMessage}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}
