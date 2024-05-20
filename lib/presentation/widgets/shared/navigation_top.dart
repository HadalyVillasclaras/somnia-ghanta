import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:go_router/go_router.dart';

class NavigationTop extends ConsumerWidget implements PreferredSizeWidget {
  const NavigationTop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizes = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    final currentLocation = _getCurrentLocation(context);
    final coursesState = ref.watch(coursesStateProvider);

    final currentCourse = coursesState.courses.firstWhere((course) => course.phases.isNotEmpty);

    String iconForRoute(String route, String iconBaseName) {
      final isActive = currentLocation.startsWith(route);
      return 'assets/icons/nav/$iconBaseName${isActive ? '_filled' : '_outline'}.png';
    }

    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: InkWell(
        onTap: () {
          context.go('/course/4'); 
        },
        child: Image.asset(
          'assets/images/logo-ghanta.png',
          height: sizes.height * 0.03,
          fit: BoxFit.scaleDown,
        ),
      ),
      backgroundColor: theme.primary,
      actions: [
        IconButton(
          onPressed: () {
            context.go('/course/${currentCourse.id}'); 
          },
          icon: Image.asset(
            iconForRoute('/course/${currentCourse.id}', 'flor'),
            height: 28,
          ),
        ),
        IconButton(
          onPressed: () {
            context.push('/home/1'); 
          },
          icon: Image.asset(
            iconForRoute('/home/1', 'calendar'),
            height: 28,
          ),
        ),
        IconButton(
          onPressed: () {
            context.go('/home/3'); 
          },
          icon: Image.asset(
            iconForRoute('/home/3', 'settings'),
            height: 28,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  String _getCurrentLocation(BuildContext context) {
    final GoRouter router = GoRouter.of(context);
    final RouteMatch lastMatch = router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch ? lastMatch.matches : router.routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
