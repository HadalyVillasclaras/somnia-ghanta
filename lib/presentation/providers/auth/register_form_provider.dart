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
  final Set<String> editedFieldsAfterSubmit;
  final bool isRegisterOk;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = '',
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.passwordConfirmation = const PasswordConfirmation.pure(),
    this.editedFieldsAfterSubmit = const <String>{},
    this.isRegisterOk = false
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    String? name,
    Email? email,
    Password? password,
    PasswordConfirmation? passwordConfirmation,
    Set<String>? editedFieldsAfterSubmit,
    bool? arePasswordsEqual,
    bool? isRegisterOk
  }) =>
    RegisterFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      editedFieldsAfterSubmit: editedFieldsAfterSubmit ?? this.editedFieldsAfterSubmit,
      isRegisterOk: isRegisterOk ?? this.isRegisterOk
    );

  
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
        isRegisterOk: $isRegisterOk
    ''';
  }
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String, String) registerUserCallback; 

  RegisterFormNotifier({required this.registerUserCallback})
      : super(RegisterFormState());

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    final updatedFields = Set<String>.from(state.editedFieldsAfterSubmit)..add('email');
    state = state.copyWith(
      email: newEmail,
      editedFieldsAfterSubmit: updatedFields,
      isValid: Formz.validate([newEmail, state.password]),
    );
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    final updatedFields = Set<String>.from(state.editedFieldsAfterSubmit)..add('password');
    state = state.copyWith(
      password: newPassword,
      editedFieldsAfterSubmit: updatedFields,
      isValid: Formz.validate([state.email, newPassword]),
    );
  }

  onPasswordConfirmationChanged(String value) {
    final newPasswordConfirmation = PasswordConfirmation.dirty(
      originalPassword: state.password.value,
      passwordConfirmation: value,
    );
    final updatedFields = Set<String>.from(state.editedFieldsAfterSubmit)..add('passwordConfirmation');

    state = state.copyWith(
      passwordConfirmation: newPasswordConfirmation,
      editedFieldsAfterSubmit: updatedFields,
      isValid: Formz.validate([state.password, newPasswordConfirmation,]),
    );
  }

  onNameChanged(String value) {
    final updatedFields = Set<String>.from(state.editedFieldsAfterSubmit)..add('name');

    state = state.copyWith(
      name: value,
      editedFieldsAfterSubmit: updatedFields,
    );
  }

  onFormSubmit() async {
     _touchEveryField();
    if (!state.isValid) return;
    
    state = state.copyWith(isPosting: true);
    
    await Future.delayed(
      const Duration(milliseconds: 1000)); //ralentizamos para que salga el spinner

    registerUserCallback(
      state.name, 
      state.email.value, 
      state.password.value,
      state.passwordConfirmation.value
    );

    state = state.copyWith(isPosting: false);
    state = state.copyWith(isFormPosted: true);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final passwordConfirmation = PasswordConfirmation.dirty(
    originalPassword: state.password.value, 
    passwordConfirmation: state.passwordConfirmation.value
  );

    state = state.copyWith(
      isFormPosted: true,
      isPosting: false,
      name: state.name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      isValid: Formz.validate([email, password, passwordConfirmation]),
      editedFieldsAfterSubmit: <String>{},
      isRegisterOk: false
    );
  }

}
