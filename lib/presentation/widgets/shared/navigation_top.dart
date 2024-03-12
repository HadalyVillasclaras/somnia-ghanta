import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationTop extends StatelessWidget implements PreferredSizeWidget {
  const NavigationTop({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white
      ),
      surfaceTintColor: Colors.transparent,
      title: Image.asset(
        theme.brightness == Brightness.dark
          ? 'assets/images/logo_negativo.png'
          : 'assets/images/logo_positivo.png',
        height: sizes.height * 0.08,
        fit: BoxFit.scaleDown,
      ),
      backgroundColor: Color.fromARGB(255, 20, 27, 61),
       actions: [
          IconButton(
            onPressed: () {
              context.go('/home/1');
            },
            icon: const Icon(
              Icons.calendar_today_outlined,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              //Profile
              context.go('/home/3');
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
        ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
