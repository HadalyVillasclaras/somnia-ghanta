import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/enviroment.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authProvider).authStatus;

    if (authStatus == AuthStatus.authenticated) {
      
      ref.read(coursesProvider.notifier).getUserCourses(Environment.apiToken);

      Future.delayed(const Duration(seconds: 1), () {
        final course = ref
            .watch(coursesProvider)
            .firstWhere((course) => course.phases.isNotEmpty);

        final courseId = course.id;
        //  context.go('/home/3');



        context.go('/course/${course.id}');
      });
    } else if (authStatus == AuthStatus.unauthenticated) {
      Future.microtask(() => context.go('/login'));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_positivo.png'),
            const SizedBox(height: 20),
            const Text('Cargando...'),
          ],
        ),
      ),
    );
  }
}
