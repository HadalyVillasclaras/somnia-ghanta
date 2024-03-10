import 'package:flutter/material.dart';

class NavigationTop extends StatelessWidget implements PreferredSizeWidget {
  const NavigationTop({super.key, this.backgroundTransparent = false, this.showLogo = true});

  final bool backgroundTransparent;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    return AppBar(
      //Trailing icon color
      iconTheme: IconThemeData(
        color: backgroundTransparent
            ? Colors.white
            : Theme.of(context).colorScheme.primary,
      ),
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      title: showLogo ? Image.asset(
        backgroundTransparent
            ? 'assets/images/logo_negativo.png'
            : theme.brightness == Brightness.dark
                ? 'assets/images/logo_negativo.png'
                : 'assets/images/logo_positivo.png',
        height: sizes.height * 0.08,
        fit: BoxFit.scaleDown,
      ) : null,
      backgroundColor: backgroundTransparent
          ? Colors.transparent
          : Theme.of(context).colorScheme.background,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
          color: backgroundTransparent
              ? Colors.white
              : Theme.of(context).colorScheme.primary,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
          color: backgroundTransparent
              ? Colors.white
              : Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
