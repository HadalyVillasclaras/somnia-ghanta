import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:ghanta/presentation/views/settings/setting_account.dart';
import 'package:ghanta/presentation/views/settings/setting_help.dart';
import 'package:ghanta/presentation/views/settings/setting_language.dart';
import 'package:ghanta/presentation/views/settings/setting_option_wrapper.dart';
import 'package:ghanta/presentation/views/settings/setting_privacy.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:go_router/go_router.dart';

class HomeViewConfig extends StatefulWidget {
  const HomeViewConfig({Key? key}) : super(key: key);

  @override
  State<HomeViewConfig> createState() => _HomeViewConfigState();
}

class _HomeViewConfigState extends State<HomeViewConfig> {
  int _selectedIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 15,
            ),
            label: const Text('Volver', style: TextStyle(color: Colors.grey)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  HomeConfigList(onChangeIndex: _changeIndex),
                  SettingOptionWrapper(
                    title: 'Mi cuenta',
                    child: const SettingAccount(),
                    onBack: () => _changeIndex(0),
                  ),
                  SettingOptionWrapper(
                    title: 'Idioma',
                    child: const SettingLanguage(),
                    onBack: () => _changeIndex(0),
                  ),
                  SettingOptionWrapper(
                    title: 'Privacidad',
                    child: const SettingPrivacy(),
                    onBack: () => _changeIndex(0),
                  ),
                  SettingOptionWrapper(
                    title: 'Ayuda',
                    child: const SettingHelp(),
                    onBack: () => _changeIndex(0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeConfigList extends StatelessWidget {
  final Function(int) onChangeIndex;

  const HomeConfigList({
    Key? key,
    required this.onChangeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Text(
          'Configuración',
          style: theme.textTheme.headlineLarge,
        ),
        const SizedBox(height: 40),
        Expanded(child: ConfigOptions(onTap: onChangeIndex)),
      ]);
  }
}

class ConfigOptions extends StatelessWidget {
  final Function(int) onTap;
  const ConfigOptions({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Mi cuenta'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () {
          onTap(1);
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.language),
        title: const Text('Idioma'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () {
          onTap(2);
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.lock),
        title: const Text('Privacidad'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () {
          onTap(3);
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.help),
        title: const Text('Ayuda'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () {
          onTap(4);
        },
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const LogoutModal();
            },
          );
        },
      ),
      const Divider(),
    ]);
  }
}

