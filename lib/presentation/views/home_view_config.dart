import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:go_router/go_router.dart';

class HomeViewConfig extends StatelessWidget {
  const HomeViewConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xF09E0A56),
              expandedHeight: sizes.height * 0.25,
              foregroundColor: Colors.pink,
              toolbarHeight: 10,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/config-bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo_negativo.png',
                      width: sizes.width * 0.6,
                      color: Colors.white.withOpacity(0.2),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                centerTitle: true,
                title: Text(
                  'Configuración',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            const ConfigOptions(),
          ],
        ));
  }
}

class ConfigOptions extends ConsumerWidget {
  const ConfigOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildListDelegate([
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Mi cuenta'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notificaciones'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Idioma'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Privacidad'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Ayuda'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Cerrar sesión'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            ref.read(authProvider.notifier).logout(errorMessage: '¡Hasta pronto!');

            Future.microtask(() => context.go('/login'));
          },
        ),
        const Divider(),
      ]),
    );
  }
}
