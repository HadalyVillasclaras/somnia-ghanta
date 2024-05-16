import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:ghanta/domain/entities/user.dart';
import 'package:ghanta/infraestructure/inputs/password.dart';
import 'package:ghanta/infraestructure/inputs/password_confirmation.dart';
import 'package:ghanta/presentation/providers/_providers.dart';

final changePasswordProvider = StateNotifierProvider.autoDispose<
ChangePassFormNotifier, ChangePassFormState>((ref) {
    final verifyPasswordCallback = ref.watch(authProvider.notifier).verifyPassword;
    final updateUserCallback = ref.watch(authProvider.notifier).updateUser;
     final user = ref.read(authProvider).user;

    return ChangePassFormNotifier(
      verifyPasswordCallback: verifyPasswordCallback,
      updateUserCallback: updateUserCallback,
      user: user,
      );
  });

class ChangePassFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isFormValid;
  final String currentPassword;
  final bool isCurrentPassValid;
  final Password newPassword;
  final PasswordConfirmation newPasswordConfirmation;
  final Set<String> editedFieldsAfterSubmit;

  ChangePassFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isFormValid = false,
    this.isCurrentPassValid = false,
    this.currentPassword = '',
    this.newPassword = const Password.pure(),
    this.newPasswordConfirmation = const PasswordConfirmation.pure(),
    this.editedFieldsAfterSubmit = const <String>{},
  });

  @override
  String toString() {
    return '''
      ChangePassFormState
        isPosting: $isPosting
        isFormPosted: $isFormPosted
        isFormValid: $isFormValid
        isCurrentPassValid: $isCurrentPassValid
        currentPassword: $currentPassword
        newPassword: $newPassword
        newPasswordConfirmation: $newPasswordConfirmation
    ''';
  }

  ChangePassFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isFormValid,
    bool? isCurrentPassValid,
    String? currentPassword,
    Password? newPassword,
    PasswordConfirmation? newPasswordConfirmation,
    Set<String>? editedFieldsAfterSubmit,
  }) =>
      ChangePassFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isFormValid: isFormValid ?? this.isFormValid,
        isCurrentPassValid: isCurrentPassValid ?? this.isCurrentPassValid,
        currentPassword: currentPassword ?? this.currentPassword,
        newPassword: newPassword ?? this.newPassword,
        newPasswordConfirmation:
            newPasswordConfirmation ?? this.newPasswordConfirmation,
        editedFieldsAfterSubmit:
            editedFieldsAfterSubmit ?? this.editedFieldsAfterSubmit,
      );
}

class ChangePassFormNotifier extends StateNotifier<ChangePassFormState> {
  final Function(String) verifyPasswordCallback;
  final Function(int, String, String, String) updateUserCallback;
  final User? user;

  ChangePassFormNotifier({
    required this.verifyPasswordCallback,
    required this.updateUserCallback,
    required this.user,
  }) : super(ChangePassFormState()
  );  

  void onCurrentPasswordChange(String value) {
    final updatedFields = Set<String>.from(state.editedFieldsAfterSubmit)
      ..add('currentPassword');

    state = state.copyWith(
      currentPassword: value,
      editedFieldsAfterSubmit: updatedFields,
      isFormValid: true,
    );
  }

  void onNewPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    final updatedFields = Set<String>.from(state.editedFieldsAfterSubmit)
      ..add('newPassword');

    state = state.copyWith(
      newPassword: newPassword,
      editedFieldsAfterSubmit: updatedFields,
      isFormValid: Formz.validate([newPassword]),
    );
  }

  void onNewPasswordConfirmationChange(String value) {
    final newPasswordConfirmation = PasswordConfirmation.dirty(
      originalPassword: state.newPassword.value,
      passwordConfirmation: value,
    );
    final updatedFields = Set<String>.from(state.editedFieldsAfterSubmit)
      ..add('newPasswordConfirmation');

    state = state.copyWith(
      newPasswordConfirmation: newPasswordConfirmation,
      editedFieldsAfterSubmit: updatedFields,
      isFormValid: Formz.validate([newPasswordConfirmation]),
    );
  }

  Future<void> onFormSubmit() async {
    _touchEveryField();
    if (!state.isFormValid) return;
    state = state.copyWith(isPosting: true);

    await Future.delayed(const Duration(milliseconds: 1000));

    final isValidCurrentPass = await verifyPasswordCallback(state.currentPassword);
   
   if (!isValidCurrentPass) { 
      state = state.copyWith(
        isPosting: false,
        isFormPosted: true,
        isCurrentPassValid: isValidCurrentPass,
      );
      return;
    }

    final isUpdateSuccessful = await updateUserCallback(
      user!.id,
      user!.name,
      user!.email,
      state.newPassword.value,
    );


    if (isUpdateSuccessful && isValidCurrentPass) {
      state = state.copyWith(
        isPosting: false, 
        isFormPosted: true, 
        isCurrentPassValid: true, 
      );

    } else {
      state = state.copyWith(
        isPosting: false, 
        isFormPosted: true, 
        isCurrentPassValid: isValidCurrentPass, 
      );
    }
  }

  void _touchEveryField() {
    final newPassword = Password.dirty(state.newPassword.value);
    final newPasswordConfirmation = PasswordConfirmation.dirty(
        originalPassword: state.newPassword.value,
        passwordConfirmation: state.newPasswordConfirmation.value);

    state = state.copyWith(
      isFormPosted: true,
      isPosting: false,
      currentPassword: state.currentPassword,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
      editedFieldsAfterSubmit: <String>{},
    );
  }
}
