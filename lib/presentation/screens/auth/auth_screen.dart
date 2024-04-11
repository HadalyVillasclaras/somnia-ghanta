import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/enviroment.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:ghanta/presentation/providers/new_courses_provider.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final auth = ref.watch(authProvider);
    final authStatus = auth.authStatus;
    final userToken = Environment.apiToken;
    final courses = ref.watch(newCoursesProvider);

    // WidgetsBinding.instance.addPostFrameCallback((_) async{
    //   await Future.delayed(Duration(seconds: 2));
    //   if (context.mounted) { 
    //     if (authStatus == AuthStatus.authenticated) {
    //       ref.read(newCoursesProvider.notifier).getUserCourses(userToken);
    //       print('NJKFSGSGFSG');
    //       print(courses.courses);

    //       context.go('/course/0');
    //     } else if (authStatus == AuthStatus.unauthenticated) {
    //       print('not aunthenticated!');
    //       context.go('/login');
    //     }
    //   }
    // });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      
      if (context.mounted) {
      final auth = ref.watch(authProvider);
      final authStatus = auth.authStatus;

        if (authStatus == AuthStatus.authenticated) {
          ref
            .read(coursesProvider.notifier)
            .getUserCourses(Environment.apiToken);
          final course = ref.watch(coursesProvider);
         
          if (course.isEmpty) {
            context.go('/home/0');
          } else {
            final notEmptyCourse =
                course.firstWhere((course) => course.phases.isNotEmpty);
            context.go('/course/${notEmptyCourse.id}');
          }
        } else if (authStatus == AuthStatus.unauthenticated) {
          context.go('/login');
        }
      }
    });

    //While waiting, show the SplashScreen
    return const SplashScreen();
  }
}
