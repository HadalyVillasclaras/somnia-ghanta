
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:ghanta/infraestructure/inputs/email.dart';
import 'package:ghanta/infraestructure/inputs/password.dart';
import 'package:ghanta/presentation/providers/_providers.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {

      final loginCallback = ref.watch(authProvider.notifier).loginUser;
  return LoginFormNotifier(loginCallback: loginCallback);
});

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isFormValid;
  final Email isEmailValid;
  final Password isPasswordValid;

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isFormValid,
    Email? isEmailValid,
    Password? isPasswordValid,
  }) =>
      LoginFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isFormValid: isFormValid ?? this.isFormValid,
          isEmailValid: isEmailValid ?? this.isEmailValid,
          isPasswordValid: isPasswordValid ?? this.isPasswordValid);

  LoginFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isFormValid = false,
      this.isEmailValid = const Email.pure(),
      this.isPasswordValid = const Password.pure()});

  @override
  String toString() {
    return '''
      LoginFormState:
        isPosting: $isPosting,
        isFormPosted: $isFormPosted,
        isFormValid: $isFormValid,
        isEmailValid: $isEmailValid,
        isPasswordValid: $isPasswordValid,
    ''';
  }
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {

  final Function(String, String) loginCallback;

  LoginFormNotifier({required this.loginCallback}) : super(LoginFormState());

  onEmailChange(String email) {
    final newEmail = Email.dirty(email);
    state = state.copyWith(
        isEmailValid: newEmail,
        isFormValid: Formz.validate([newEmail, state.isPasswordValid]));
  }

  onPasswordChange(String password) {
    final newPassword = Password.dirty(password);
    state = state.copyWith(
        isPasswordValid: newPassword,
        isFormValid: Formz.validate([newPassword, state.isEmailValid]));
  }

  onFormSubmitted() {
    _touchEveryField();
    state = state.copyWith(isFormPosted: true);
    if (!state.isFormValid) return;
    loginCallback(state.isEmailValid.value, state.isPasswordValid.value);
  }

  _touchEveryField() {
    final email = Email.dirty(state.isEmailValid.value);
    final password = Password.dirty(state.isPasswordValid.value);

    state = state.copyWith(
        isEmailValid: email,
        isPasswordValid: password,
        isFormValid: Formz.validate([email, password]));
  }
}
