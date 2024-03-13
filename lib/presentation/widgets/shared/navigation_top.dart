import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationTop extends StatelessWidget implements PreferredSizeWidget {
  const NavigationTop({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(
        color: Colors.white
      ),
      title: Image.asset(
        'assets/images/logo-ghanta.png',
        height: sizes.height * 0.03,
        fit: BoxFit.scaleDown,
      ),
      backgroundColor: theme.primary,
       actions: [
          IconButton(
            onPressed: () {
              context.push('/home/0'); //HomeView
            },
            icon: const Icon(
              Icons.calendar_today_outlined,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              //Profile
              context.push('/home/3'); //HomeViewConfig
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
