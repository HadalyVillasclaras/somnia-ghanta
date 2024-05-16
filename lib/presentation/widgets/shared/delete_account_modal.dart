import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/auth/auth_provider.dart';
import 'package:ghanta/presentation/providers/auth/change_password_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:ghanta/presentation/providers/_providers.dart';

class DeleteAccountModal extends ConsumerWidget {
  const DeleteAccountModal({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize
              .min, // Making the dialog content take only the space it needs
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 30,
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Text(
                "¿Seguro que quieres eliminar tu cuenta?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the current (Delete Account) modal
                      Future.delayed(const Duration(milliseconds: 100), () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const EnterPasswordModal();
                          },
                        );
                      });
                    },
                    child: const Text('Sí'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Cancelar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EnterPasswordModal extends ConsumerStatefulWidget {
  const EnterPasswordModal({
    super.key,
  });

  @override
  ConsumerState<EnterPasswordModal> createState() => _EnterPasswordModalState();
}

class _EnterPasswordModalState extends ConsumerState<EnterPasswordModal> {
  bool _obscureText = true;
   final _passwordController = TextEditingController();
  String _localErrorMessage = '';

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_clearLocalErrorMessage);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_clearLocalErrorMessage);
    _passwordController.dispose();
    super.dispose();
  }

  void _clearLocalErrorMessage() {
    if (_localErrorMessage.isNotEmpty) {
      setState(() {
        _localErrorMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final changePassState = ref.watch(changePasswordProvider);
    final changePassNotifier = ref.watch(changePasswordProvider.notifier);

    final authState = ref.watch(authProvider);
    final authNotifier = ref.watch(authProvider.notifier);

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, 
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 30,
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Text(
                "Escribe tu contraseña para eliminar tu cuenta",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: 'Contraseña',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                }),
              errorText: _localErrorMessage.isNotEmpty
                ? 'La contraseña no es correcta.'
                : null,
              ),
                  
            ),
            const SizedBox(height: 40),
            //Buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () async{
                      final isValidPass = await authNotifier.verifyPassword(_passwordController.text);

                      if (isValidPass) {
                        ref.read(authProvider.notifier).logout();
                        Future.microtask(() => context.go('/login'));
                      } else {
                         setState(() {
                          _localErrorMessage = 'La contraseña no es correcta.';
                        });
                      }
                    },
                    child: changePassState.isPosting
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                      : const Text('Eliminar cuenta'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Cancelar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
