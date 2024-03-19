
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
  final Email email;
  final Password password;

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isFormValid,
    Email? email,
    Password? password,
  }) =>
    LoginFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isFormValid: isFormValid ?? this.isFormValid,
      email: email ?? this.email,
      password: password ?? this.password);

  LoginFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isFormValid = false,
      this.email = const Email.pure(),
      this.password = const Password.pure()});

  @override
  String toString() {
    return '''
      LoginFormState:
        isPosting: $isPosting,
        isFormPosted: $isFormPosted,
        isFormValid: $isFormValid,
        email: $email,
        password: $password,
    ''';
  }
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {

  final Function(String, String) loginCallback;

  LoginFormNotifier({required this.loginCallback}) : super(LoginFormState());

  onEmailChange(String email) {
    final newEmail = Email.dirty(email);
    state = state.copyWith(
        email: newEmail,
        isFormValid: Formz.validate([newEmail, state.password]));
  }

  onPasswordChange(String password) {
    final newPassword = Password.dirty(password);
    state = state.copyWith(
      password: newPassword,
      isFormValid: Formz.validate([newPassword, state.email]));
  }

  onFormSubmitted() async{
    _touchEveryField();
    if (!state.isFormValid) return;

    state = state.copyWith(isPosting: true);
    
    await Future.delayed(
      const Duration(milliseconds: 1000)); //ralentizamos para que salga el spinner
    
    loginCallback(state.email.value, state.password.value);

    state = state.copyWith(isPosting: false);
    state = state.copyWith(isFormPosted: true);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      email: email,
      password: password,
      isFormValid: Formz.validate([email, password]));
  }
}
