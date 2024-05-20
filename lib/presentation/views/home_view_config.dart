import 'package:flutter/material.dart';
import 'package:ghanta/presentation/views/settings/account/settings_view_account.dart';
import 'package:ghanta/presentation/views/settings/settings_view_help.dart';
import 'package:ghanta/presentation/views/settings/setting_option_wrapper.dart';
// import 'package:ghanta/presentation/views/settings/settings_view_language.dart';
import 'package:ghanta/presentation/views/settings/settings_view_privacy.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

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
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                HomeConfigList(onChangeIndex: _changeIndex),
                SettingOptionWrapper(
                  title: 'Mi cuenta',
                  child: const SettingsViewAccount(),
                  onBack: () => _changeIndex(0),
                ),
                // SettingOptionWrapper(
                //   title: 'Idioma',
                //   child: const SettingsViewLanguage(),
                //   onBack: () => _changeIndex(0),
                // ),
                SettingOptionWrapper(
                  title: 'Privacidad',
                  child: const SettingsViewPrivacy(),
                  onBack: () => _changeIndex(0),
                ),
                SettingOptionWrapper(
                  title: 'Ayuda',
                  child: const SettingsViewHelp(),
                  onBack: () => _changeIndex(0),
                ),
              ],
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        leadingWidth: 200,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start, 
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
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Configuración',
            style: theme.textTheme.headlineLarge,
          ),
          const SizedBox(height: 40),
          Expanded(child: ConfigOptions(onTap: onChangeIndex)),
        ]),
      ),
    );
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
      // ListTile(
      //   leading: const Icon(Icons.language),
      //   title: const Text('Idioma'),
      //   trailing: const Icon(
      //     Icons.arrow_forward_ios,
      //     size: 15,
      //   ),
      //   onTap: () {
      //     onTap(2);
      //   },
      // ),
      // const Divider(),
      ListTile(
        leading: const Icon(Icons.lock),
        title: const Text('Privacidad'),
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
        leading: const Icon(Icons.help),
        title: const Text('Ayuda'),
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
