import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/auth/change_password_provider.dart';
import 'package:ghanta/presentation/providers/_providers.dart';

class ChangePasswordForm extends ConsumerStatefulWidget {
  const ChangePasswordForm({
    super.key,
    required this.sizes,
  });

  final Size sizes;

  @override
  ConsumerState<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends ConsumerState<ChangePasswordForm> {
  bool _obscurePass1 = true;
  bool _obscurePass2 = true;
  bool _obscurePass3 = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final changePassState = ref.watch(changePasswordProvider);
    final changePassNotifier = ref.watch(changePasswordProvider.notifier);

    ref.listen(authProvider, ((previous, next) {
      if (next.errorMessage.isEmpty &&
          changePassState.isFormValid &&
          changePassState.isFormPosted) {
        successModal(context);
      }

      if (next.errorMessage.isEmpty) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(next.errorMessage),
        ),
      );
    }));

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: widget.sizes.height * 0.05),
                const Text(
                  'Contraseña',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  onChanged: (value) {
                    changePassNotifier.onCurrentPasswordChange(value);
                  },
                  obscureText: _obscurePass1,
                  decoration: InputDecoration(
                      hintText: 'Contraseña actual',
                      prefixIcon: const Icon(Icons.lock_outline),
                      errorText: (
                          !changePassState.isPosting &&
                          changePassState.isFormPosted &&
                          !changePassState.editedFieldsAfterSubmit
                              .contains('currentPassword') &&
                          !changePassState.isCurrentPassValid)
                          ? 'La contraseña no es correcta.'
                          : null,
                      suffixIcon: IconButton(
                          icon: Icon(_obscurePass1
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscurePass1 = !_obscurePass1;
                            });
                          })),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  onChanged: (value) {
                    changePassNotifier.onNewPasswordChange(value);
                  },
                  obscureText: _obscurePass2,
                  decoration: InputDecoration(
                      hintText: 'Nueva contraseña',
                      errorText: (!changePassState.isPosting &&
                              changePassState.isFormPosted &&
                              !changePassState.editedFieldsAfterSubmit
                                  .contains('newPassword'))
                          ? changePassState.newPassword.errorMessage
                          : null,
                      prefixIcon: Transform.rotate(
                        angle:
                            90, // Rotate the icon 90 degrees counter-clockwise
                        child: const Icon(Icons.key),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(_obscurePass2
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscurePass2 = !_obscurePass2;
                            });
                          })),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    changePassNotifier.onNewPasswordConfirmationChange(value);
                  },
                  obscureText: _obscurePass3,
                  decoration: InputDecoration(
                      hintText: 'Confirma nueva contraseña',
                      errorText: (!changePassState.isPosting &&
                              changePassState.isFormPosted &&
                              !changePassState.editedFieldsAfterSubmit
                                  .contains('newPasswordConfirmation'))
                          ? changePassState.newPasswordConfirmation.errorMessage
                          : null,
                      prefixIcon: Transform.rotate(
                        angle:
                            90, // Rotate the icon 90 degrees counter-clockwise
                        child: const Icon(Icons.key),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(_obscurePass3
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscurePass3 = !_obscurePass3;
                            });
                          })),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      ref.read(changePasswordProvider.notifier).onFormSubmit();
                      // Cerramos el teclado
                      FocusScope.of(context).unfocus();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: changePassState.isPosting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Cambiar contraseña',
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> successModal(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17)),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tu nueva contraseña se ha guardado correctamente.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
  }
}
