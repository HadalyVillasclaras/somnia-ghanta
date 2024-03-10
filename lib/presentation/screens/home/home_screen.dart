import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/ui_provider.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key, required this.tabIndex}) : super(key: key);

  final int tabIndex;

  @override
  Widget build(BuildContext context, ref) {
    bool isTransparent = false;
    bool showLogo = false;
    final navbarTransparent = ref.watch(navbarTransparentProvider(tabIndex));
    navbarTransparent.whenData((value) => isTransparent = value);
    final showLogoProv  = ref.watch(showLogoProvider(tabIndex));
    showLogoProv.whenData((value) => showLogo = value);

    return Scaffold(
      extendBodyBehindAppBar: true,
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   currentIndex: tabIndex,
      // ),
      appBar: NavigationTop(backgroundTransparent: isTransparent, showLogo: showLogo),
      body: IndexedStack(
          index: tabIndex,
          children: const [
            HomeView(), 
            HomeProfileView(),
            HomeCoursesView(), 
            HomeViewConfig(), 
            ]),
    );
  }
}
