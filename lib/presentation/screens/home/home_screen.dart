import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:ghanta/presentation/views/home_view_calendar.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key, required this.tabIndex  }) : super(key: key);
// final Widget child;
  final int tabIndex;

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const NavigationTop(),
      body: IndexedStack(
        index: tabIndex,
        children: const [
          HomeView(), 
          //esto causa problemas porque todas las views estan cargando a la vez, incluida las calls a la api....
          // HomeProfileView(),
          HomeCalendarView(),
          HomeCoursesView(), 
          HomeViewConfig(), 
          ]),
    );
  }
}
