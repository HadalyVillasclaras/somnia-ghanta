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
  final Set<String> editedFieldsAfterSubmit;
  final bool wasFormSubmitted;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isFormValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.editedFieldsAfterSubmit = const <String>{},
    this.wasFormSubmitted = false    
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isFormValid,
    Email? email,
    Password? password,
    Set<String>? editedFieldsAfterSubmit,
    bool? wasFormSubmitted
  }) =>
    LoginFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isFormValid: isFormValid ?? this.isFormValid,
      email: email ?? this.email,
      password: password ?? this.password,
      editedFieldsAfterSubmit: editedFieldsAfterSubmit ?? this.editedFieldsAfterSubmit,
      wasFormSubmitted: wasFormSubmitted ?? this.wasFormSubmitted    
    );

 
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginCallback;

  LoginFormNotifier({required this.loginCallback}) : super(LoginFormState());

  onEmailChange(String email) {
    final newEmail = Email.dirty(email);
    final updatedFields = Set<String>.from(state.editedFieldsAfterSubmit)..add('email');

    state = state.copyWith(
        email: newEmail,
        editedFieldsAfterSubmit: updatedFields,
        isFormValid: Formz.validate([newEmail, state.password]));
  }

  onPasswordChange(String password) {
    final newPassword = Password.dirty(password);
    final updatedFields = Set<String>.from(state.editedFieldsAfterSubmit)..add('password');
    
    state = state.copyWith(
        password: newPassword,
        editedFieldsAfterSubmit: updatedFields,
        isFormValid: Formz.validate([state.email, newPassword]));
  }

  onFormSubmitted() async {
    _touchEveryField();
    if (!state.isFormValid) return;

    state = state.copyWith(isPosting: true);

    await Future.delayed(const Duration(
        milliseconds: 1000)); //ralentizamos para que salga el spinner

     final loginSuccess = await loginCallback(state.email.value, state.password.value);

    if (loginSuccess) {
      // Reset state after successful login
      state = LoginFormState();
    } else {
      state = state.copyWith(isPosting: false, isFormPosted: true, wasFormSubmitted: true);
    }

  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      isPosting: false,
      email: email,
      password: password,
      isFormValid: Formz.validate([email, password]),
      editedFieldsAfterSubmit: <String>{},
      );
  }
}
