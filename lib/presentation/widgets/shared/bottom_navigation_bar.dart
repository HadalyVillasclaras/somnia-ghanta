import 'package:flutter/material.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        onTap: (p0) => context.go('/home/$p0'),
        currentIndex: currentIndex,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title:  Text(Lang.of(context).bottom_bar_home),
            selectedColor: const Color(0xFFA23957),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title:  Text(Lang.of(context).bottom_bar_profile),
            selectedColor: const Color(0xFFA23957),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.store),
            title:  Text( Lang.of(context).bottom_bar_courses),
            selectedColor: const Color(0xFFA23957),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings),
            title:  Text(Lang.of(context).bottom_bar_settings),
            selectedColor: const Color(0xFFA23957),
          ),
          
        ]);
  }
}
