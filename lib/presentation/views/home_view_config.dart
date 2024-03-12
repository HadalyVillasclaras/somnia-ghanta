import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:go_router/go_router.dart';

class HomeViewConfig extends StatelessWidget {
  const HomeViewConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          TextButton.icon(
            onPressed: () {
              context.go('/');
            },
            icon:const Icon(Icons.arrow_back_ios,color: Colors.grey, size: 15,), 
            label: const Text('Volver', style: TextStyle( color: Colors.grey)), 
          ),
          const Expanded(
            child:  Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Text('Configuración',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
                  SizedBox(height: 40),
                  Expanded(child: ConfigOptions()),
                ]),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfigOptions extends ConsumerWidget {
  const ConfigOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(children: [
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Mi cuenta'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () {},
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.language),
        title: const Text('Idioma'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () {},
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.lock),
        title: const Text('Privacidad'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () {},
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.help),
        title: const Text('Ayuda'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () {},
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text('Cerrar sesión'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () {
          ref
              .read(authProvider.notifier)
              .logout(errorMessage: '¡Hasta pronto!');
          Future.microtask(() => context.go('/login'));
        },
      ),
      const Divider(),
    ]);
  }
}
