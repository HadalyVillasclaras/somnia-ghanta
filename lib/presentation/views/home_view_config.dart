import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:ghanta/presentation/views/settings/setting_account.dart';
import 'package:ghanta/presentation/views/settings/setting_help.dart';
import 'package:ghanta/presentation/views/settings/setting_language.dart';
import 'package:ghanta/presentation/views/settings/setting_option_wrapper.dart';
import 'package:ghanta/presentation/views/settings/setting_privacy.dart';
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Configuración',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)),
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
        onTap: () {onTap(3);},
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.help),
        title: const Text('Ayuda'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () {onTap(4);},
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
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Making the dialog box a bit rounded
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Making the dialog content take only the space it needs
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(), // Close the dialog
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "¿Seguro que quieres salir de la aplicación?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                     style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Button color
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Text color
                        elevation: MaterialStateProperty.all<double>(2), // Shadow
                      ),
                      onPressed: () {
                        // Your action for "No"
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('No'),
                    ),
                  ),
                  const SizedBox(width: 10), // Spacing between buttons
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Button color
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Text color
                        elevation: MaterialStateProperty.all<double>(2), // Shadow
                      ),
                      onPressed: () {
                        // Your action for "Yes"
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('Sí'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
          // ref
          //     .read(authProvider.notifier)
          //     .logout(errorMessage: '¡Hasta pronto!');
          // Future.microtask(() => context.go('/login'));
        },
      ),
      const Divider(),
    ]);
  }
}
