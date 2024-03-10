import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:ghanta/infraestructure/inputs/email.dart';
import 'package:ghanta/infraestructure/inputs/password.dart';
import 'package:ghanta/infraestructure/inputs/password_confirmation.dart';
import 'package:ghanta/presentation/providers/_providers.dart';

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final String name;
  final Email email;
  final Password password;
  final PasswordConfirmation passwordConfirmation;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = '',
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.passwordConfirmation = const PasswordConfirmation.pure(),
  });

  @override
  String toString() {
    return '''
      RegisterFormState
        isPosting: $isPosting
        isFormPosted: $isFormPosted
        isValid: $isValid
        name: $name
        email: $email
        password: $password
        passwordConfirmation: $passwordConfirmation
    ''';
  }

  RegisterFormState copyWith(
    {bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    String? name,
    Email? email,
    Password? password,
    PasswordConfirmation? passwordConfirmation,
    bool? arePasswordsEqual}) =>
RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    name: name ?? this.name,
    email: email ?? this.email,
    password: password ?? this.password,
    passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String, String)
      registerUserCallback; //esto seria el caso de uso para realizar la autenticacion

  RegisterFormNotifier({required this.registerUserCallback})
      : super(RegisterFormState());

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail, isValid: Formz.validate([newEmail, state.password]));
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email]));
  }

  onPasswordConfirmationChanged(String value) {
    final newPasswordConfirmation = PasswordConfirmation.dirty(
      originalPassword: state.password.value,
      passwordConfirmation: value,
    );
    state = state.copyWith(
      passwordConfirmation: newPasswordConfirmation,
      isValid: Formz.validate([state.password, newPasswordConfirmation,]),
    );
  }

  onNameChanged(String value) {
    state = state.copyWith(
      name: value,
    );
  }

  onFormSubmit() async {
    _touchEveryField();

    print(state);
    // if (!state.isValid) return;
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final passwordConfirmation = PasswordConfirmation.dirty(
    originalPassword: state.password.value, 
    passwordConfirmation: state.passwordConfirmation.value
  );
    //esto es para que cuando haya un cambio en el estado, se notifica a todos los listeners que estén pendiente de este estado
    state = state.copyWith(
        isFormPosted: true,
        name: state.name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        isValid: Formz.validate([email, password, passwordConfirmation]),
        );
  }
}
