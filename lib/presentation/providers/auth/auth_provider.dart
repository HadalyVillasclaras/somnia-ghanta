import 'dart:convert';
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

  AuthNotifier({
    required this.authRepository, 
    required this.keyValueStorageService
  }): super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000)); //ralentizamos un poco el log

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on WrongCredentialsError {
      logout(errorMessage: 'Credenciales incorrectas');
      print('onwrong credentials');
      state = state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          errorMessage: 'Credenciales incorrectas');
    } catch (e) {
      logout(errorMessage: 'Ha ocurrido un error');
    }
  }

    Future<void> registerUser(String name, String email, String password, String passwordConfirmation) async {
    await Future.delayed(const Duration(milliseconds: 1000)); //ralentizamos un poco el log

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on WrongCredentialsError {
      logout(errorMessage: 'Credenciales incorrectas');
      print('onwrong credentials');
      state = state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          errorMessage: 'Credenciales incorrectas');
    } catch (e) {
      logout(errorMessage: 'Ha ocurrido un error');
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
    final String token = await keyValueStorageService.getValue<String>('token') ?? '';

    if (token.isNotEmpty) {
      try {
        await authRepository.logout(token);
      } on WrongCredentialsError {
        await keyValueStorageService.removeKey('token');
      } catch (e) {
        print(e.toString());
      }
    }

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

  AuthState copyWith({
    AuthStatus? authStatus, 
    User? user, 
    String? errorMessage
  }) =>
    AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage
    );
}