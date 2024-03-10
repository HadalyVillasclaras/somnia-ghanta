import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    //Esta ruta redirige a la ruta /home/0
    // redirect: (context, state) => '/home/0',
    redirect: (context, state) => '/auth',
  ),
  GoRoute(
    path: '/home/:tabIndex',
    builder: (context, state) {
      final tabIndex = int.parse(state.pathParameters['tabIndex'] ?? '0');
      return HomeScreen(tabIndex: tabIndex);
    },
  ),
  GoRoute(
      path: '/course/:courseId',
      builder: (context, state) {
        final courseId = int.parse(state.pathParameters['courseId'] ?? '0');
        return CourseScreen(courseId: courseId);
      },
      routes: [
        GoRoute(
          path: 'subphase/:subphaseId',
          builder: (context, state) {
            final phaseId = int.parse(state.pathParameters['phaseId'] ?? '0');
            final subphaseId =
                int.parse(state.pathParameters['subphaseId'] ?? '0');
            final courseId = int.parse(state.pathParameters['courseId'] ?? '0');

            return SubphaseScreen(
                subphaseId: subphaseId, courseId: courseId, phaseId: phaseId);
          },
        ),
      ]),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/auth',
    builder: (context, state) => const AuthScreen(),
  ),
  GoRoute(path: '/feedback', builder: (context, state) => const FeedbackScreen()),
]);
