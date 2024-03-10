import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordConfirmationError { mismatch, empty }

class PasswordConfirmation extends FormzInput<String, PasswordConfirmationError> {
  final String originalPassword;

  // Call super.pure for an unmodified form input
  const PasswordConfirmation.pure({this.originalPassword = ''}) : super.pure('');

  // Call super.dirty for a modified form input, with the original password passed in for comparison
  const PasswordConfirmation.dirty({required this.originalPassword, String passwordConfirmation = ''}) : super.dirty(passwordConfirmation);

  @override
  PasswordConfirmationError? validator(String passwordConfirmation) {
    if (passwordConfirmation.isEmpty) {
      return PasswordConfirmationError.empty;
    } else if (originalPassword != passwordConfirmation) {
      return PasswordConfirmationError.mismatch;
    }
    return null; 
  }

  String? get errorMessage {
    if (isValid || isPure) return null;
    switch (error) {
      case PasswordConfirmationError.mismatch:
        return 'El password no coincide con el anterior';
      case PasswordConfirmationError.empty:
        return 'El campo es requerido';
      default:
        return null;
    }
  }
}
