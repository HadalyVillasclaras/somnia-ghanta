import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/auth/auth_provider.dart';
import 'package:ghanta/presentation/providers/auth/change_password_provider.dart';

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
  
  @override
  Widget build(BuildContext context ) {
    final changePassState = ref.watch(changePasswordProvider);
    final changePassNotifier = ref.watch(changePasswordProvider.notifier);
  print('isCurrentPassValid ${changePassState.isCurrentPassValid}');

    return Form(
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
            onChanged: (value) {changePassNotifier.onCurrentPasswordChange(value);},
            obscureText: _obscurePass1,
            decoration: InputDecoration(
              hintText: 'Contraseña actual',
              prefixIcon: const Icon(Icons.lock_outline),
              errorText: (!changePassState.isPosting && changePassState.isFormPosted && !changePassState.editedFieldsAfterSubmit.contains('currentPassword') && !changePassState.isCurrentPassValid)
                ? 'La contraseña no es correcta.'
                : null,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePass1 ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscurePass1 = !_obscurePass1;
                  });
                }
              )
            ),
          ),
          const SizedBox(height: 50),
          TextFormField(
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: 'Nueva contraseña',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(Icons.visibility),
                onPressed: () {})),
          ),
          const SizedBox(height: 20),
          TextFormField(
            onChanged: (value) {},
            decoration: InputDecoration(
                hintText: 'Confirma nueva contraseña',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {})),
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
              : const Text('Cambiar contraseña',)),
        ],
      ),
    );
  }
}
