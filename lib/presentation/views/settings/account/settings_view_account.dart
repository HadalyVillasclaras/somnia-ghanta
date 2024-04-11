import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/auth/auth_provider.dart';
import 'package:ghanta/presentation/widgets/shared/delete_account_modal.dart';
import 'package:ghanta/presentation/views/settings/account/change_password_form.dart';


class SettingsViewAccount extends ConsumerWidget {
  const SettingsViewAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizes = MediaQuery.of(context).size;
    final authState = ref.read(authProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 80),
        const Divider(height: 0.0),
          ListTile(
          leading: const Icon(Icons.person),
          title: Text(authState.user!.name),
        ),
        const Divider(height: 0.0),
        ListTile(
          leading: const Icon(Icons.email_outlined),
          title: Text(authState.user!.email),
        ),
        const Divider(height: 0.0),
        const ListTile(
          leading: Icon(Icons.lock_outline),
          title: Text('*********'),
        ),
        const Divider(height: 0.0),
        const SizedBox(height: 80),
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // Allows the sheet to take up the full screen height if needed
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
              ),
              builder: (BuildContext context) {
                return FractionallySizedBox(
                  heightFactor: 0.8, 
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ChangePasswordForm(sizes: sizes),
                  ),
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text(
            'Cambiar contraseña',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const DeleteAccountModal();
                },
              );
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Theme.of(context).colorScheme.tertiary),
            child: const Text(
              'Eliminar cuenta',
            )),
      ],
    );
  }
}

