import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/enviroment.dart';
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

    if (authStatus == AuthStatus.authenticated) {
      ref.watch(coursesProvider.notifier).getUserCourses(Environment.apiToken);
      final courses = ref.watch(testCourseProvider);

      courses.whenData((courses) {
        if (courses.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/home/0');
          });
        } else {
          Course? notEmptyCourse;

          for (Course course in courses) {
            if (course.phases.isNotEmpty) {
              notEmptyCourse = course;
              break; 
            }
          }

          if (notEmptyCourse != null) {
            //redireccionamos al primer curso con fase
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(coursesStateProvider.notifier).setCourses(courses);
              context.go('/course/${notEmptyCourse!.id}');
            });
          } else {
            //si ninguno tiene fases redireccionamos al primer curso aunque este vacío
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(coursesStateProvider.notifier).setCourses(courses);
              context.go(
                '/course/${courses.first.id}'); 
            });
          }
        }
      });
    } else if (authStatus == AuthStatus.unauthenticated){
      context.go('/login');
    }

    return const SplashScreen();
  }
}


//  WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await Future.delayed(const Duration(seconds: 2));
      
//       if (context.mounted) {
//       final auth = ref.watch(authProvider);
//       final authStatus = auth.authStatus;

//         if (authStatus == AuthStatus.authenticated) {
//           ref
//             .read(coursesProvider.notifier)
//             .getUserCourses(Environment.apiToken);
//           final course = ref.watch(coursesProvider);
         
//           if (course.isEmpty) {
//             context.go('/home/0');
//           } else {
//             final notEmptyCourse =
//                 course.firstWhere((course) => course.phases.isNotEmpty);
//             context.go('/course/${notEmptyCourse.id}');
//           }
//         } else if (authStatus == AuthStatus.unauthenticated) {
//           context.go('/login');
//         }
//       }
//     });