import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:ghanta/presentation/screens/auth/register_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    redirect: (context, state) => '/auth',
  ),
  GoRoute(
    path: '/home/:tabIndex',
    builder: (context, state) {
      final tabIndex = int.parse(state.pathParameters['tabIndex'] ?? '0');
      return HomeScreen(tabIndex: tabIndex);
    }
  ),
  GoRoute(
    path: '/course/:courseId',
    builder: (context, state) {
      final courseId = int.parse(state.pathParameters['courseId'] ?? '0');
      return CourseScreen(courseId: courseId);
    },
    ),
    GoRoute(
    path: '/course/:course/phase/:phaseId/subphase/:subphaseId',
    builder: (context, state) {
      final phaseId = int.parse(state.pathParameters['phaseId'] ?? '0');
      final subphaseId =
          int.parse(state.pathParameters['subphaseId'] ?? '0');

      return SubphaseScreen(
          subphaseId: subphaseId, phaseId: phaseId);
      },
    ),
    GoRoute(
      path: '/course',
      builder: (context, state) =>  const CourseEmptyScreen(),
    ),
   GoRoute(path: '/feedback/:activityId', builder: (context, state) {
    final activityId = int.parse(state.pathParameters['activityId'] ?? '0');
    return FeedbackScreen(activityId: activityId);
  }),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
  path: '/register',
  builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/auth',
    builder: (context, state) => const AuthScreen(),
  ),
]);
