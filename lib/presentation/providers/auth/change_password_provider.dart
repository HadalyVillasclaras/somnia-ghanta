import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:ghanta/infraestructure/inputs/password.dart';
import 'package:ghanta/infraestructure/inputs/password_confirmation.dart';
import 'package:ghanta/presentation/providers/_providers.dart';

final changePasswordProvider =
  StateNotifierProvider.autoDispose<ChangePassFormNotifier, ChangePassFormState>((ref) {
    final verifyPasswordCallback = ref.watch(authProvider.notifier).verifyPassword;

    return ChangePassFormNotifier(verifyPasswordCallback: verifyPasswordCallback);
  });

class ChangePassFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isCurrentPassValid;
  final String currentPassword;
  final Password newPassword;
  final PasswordConfirmation newPasswordConfirmation;
  final Set<String> editedFieldsAfterSubmit;
  final bool isRegisterOk;

  ChangePassFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isCurrentPassValid = false,
    this.currentPassword = '',
    this.newPassword = const Password.pure(),
    this.newPasswordConfirmation = const PasswordConfirmation.pure(),
    this.editedFieldsAfterSubmit = const <String>{},
    this.isRegisterOk = false
  });

  @override
  String toString() {
    return '''
      RegisterFormState
        isPosting: $isPosting
        isFormPosted: $isFormPosted
        isCurrentPassValid: $isCurrentPassValid
        currentPassword: $currentPassword
        newPassword: $newPassword
        newPasswordConfirmation: $newPasswordConfirmation
        isRegisterOk: $isRegisterOk
    ''';
  }

  ChangePassFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isCurrentPassValid,
    String? currentPassword,
    Password? newPassword,
    PasswordConfirmation? passwordConfirmation,
    Set<String>? editedFieldsAfterSubmit,
    bool? arePasswordsEqual,
    bool? isRegisterOk
  }) =>
    ChangePassFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isCurrentPassValid: isCurrentPassValid ?? this.isCurrentPassValid,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      newPasswordConfirmation: passwordConfirmation ?? this.newPasswordConfirmation,
      editedFieldsAfterSubmit: editedFieldsAfterSubmit ?? this.editedFieldsAfterSubmit,
      isRegisterOk: isRegisterOk ?? this.isRegisterOk
    );
}

class ChangePassFormNotifier extends StateNotifier<ChangePassFormState> {
  final Function(String) verifyPasswordCallback; //esto seria el caso de uso para realizar la autenticacion

  ChangePassFormNotifier({required this.verifyPasswordCallback})
      : super(ChangePassFormState());

  onCurrentPasswordChange(String value) {
    final updatedFields = Set<String>.from(state.editedFieldsAfterSubmit)..add('currentPassword');
    state = state.copyWith(
      currentPassword: value,
      editedFieldsAfterSubmit: updatedFields,
    );
  }

  onNewPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    final updatedFields = Set<String>.from(state.editedFieldsAfterSubmit)..add('newPassword');
    state = state.copyWith(
      newPassword: newPassword,
      editedFieldsAfterSubmit: updatedFields,
      isCurrentPassValid: Formz.validate([newPassword]),
    );
  }

  onNewPasswordConfirmationChange(String value) {
    final newPasswordConfirmation = PasswordConfirmation.dirty(
      originalPassword: state.newPassword.value,
      passwordConfirmation: value,
    );
    final updatedFields = Set<String>.from(state.editedFieldsAfterSubmit)..add('newPasswordConfirmation');

    state = state.copyWith(
      passwordConfirmation: newPasswordConfirmation,
      editedFieldsAfterSubmit: updatedFields,
      isCurrentPassValid: Formz.validate([state.newPassword, newPasswordConfirmation,]),
    );
  }


  Future<void> onFormSubmit([Function(dynamic)? onCompletion]) async {
     _touchEveryField();

    state = state.copyWith(isPosting: true);
    final isValidPass = await verifyPasswordCallback(state.currentPassword);
    
    await Future.delayed( const Duration(milliseconds: 1000));
    state = state.copyWith(
      isPosting: false,
      isFormPosted: true,
      isCurrentPassValid: isValidPass
    );

    if (onCompletion != null) {
    onCompletion(isValidPass);
  }
  }

  _touchEveryField() {
    final newPassword = Password.dirty(state.newPassword.value);
    final newPasswordConfirmation = PasswordConfirmation.dirty(
    originalPassword: state.newPassword.value, 
    passwordConfirmation: state.newPasswordConfirmation.value
  );

    state = state.copyWith(
      isFormPosted: true,
      isPosting: false,
      currentPassword: state.currentPassword,
      newPassword: newPassword,
      passwordConfirmation: newPasswordConfirmation,
      editedFieldsAfterSubmit: Set<String>(),
      isRegisterOk: false
    );
  }

}
