import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key, required this.tabIndex}) : super(key: key);

  final int tabIndex;

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   currentIndex: tabIndex,
      // ),
      appBar: const NavigationTop(),
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
