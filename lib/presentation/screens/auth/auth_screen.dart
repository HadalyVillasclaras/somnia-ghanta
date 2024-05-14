import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/_domain.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authStatus == AuthStatus.authenticated) {
        // ref.watch(coursesStateProvider.notifier).getUserCourses();
        final courses = ref.watch(getCoursesProvider);

        courses.whenData((courses) {
          if (courses.isEmpty) {
            Future.delayed(
                const Duration(seconds: 2), () => context.go('/course'));
            return;
          } else {
            Course? notEmptyCourse;

            for (Course course in courses) {
              if (course.phases.isNotEmpty) {
                notEmptyCourse = course;
                break;
              }
            }

            if (notEmptyCourse != null) {
              ref.read(coursesStateProvider.notifier).setCourses(courses);
              Future.delayed(const Duration(seconds: 2),
                () => context.go('/course/${notEmptyCourse!.id}'));
            } else {
              Future.delayed(const Duration(seconds: 2), 
                () => context.go('/course'));
            }
          }
        });
      } else {
        context.go('/login');
      }
    });
    return const SplashScreen();
  }
}
