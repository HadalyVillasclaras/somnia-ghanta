import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/infraestructure/datasources/courses_datasource_impl.dart';
import 'package:ghanta/presentation/providers/auth/auth_provider.dart';

final testCourseProvider = FutureProvider<List<Course>>((ref) async {
  final coursesRepository = CoursesDatasourceImpl();
  final authState = ref.read(authProvider);
  final userId = authState.user!.id;
  final userToken = authState.user?.token; 
  await Future.delayed(const Duration(seconds: 2));
  final courses = await coursesRepository.getNewUserCourses(userId, userToken!);
  
  return courses;
});


final subphaseProvider = FutureProvider.family<Subphase, int>((ref, subphaseId) async {
  final coursesRepository = CoursesDatasourceImpl();
  final subphase = await coursesRepository.getSubphaseById(subphaseId);
  
  return subphase;
});


final coursesStateProvider = StateNotifierProvider<CoursesNotifier, CoursesState>((ref) {
   final authState = ref.read(authProvider);
  final userId = authState.user!.id;
  final userToken = authState.user?.token; 
  return CoursesNotifier(userId, userToken);
});

class CoursesNotifier extends StateNotifier<CoursesState> {
  final int userId;
  final String? userToken;
  final CoursesDatasource _coursesDatasource = CoursesDatasourceImpl();

  CoursesNotifier(this.userId, this.userToken) : super(CoursesState());

  Future<void> getUserCourses(userId, userToken) async {
    state = state.copyWith(status: CoursesStatus.loading);
      try {
        final courses = await _coursesDatasource.getNewUserCourses(userId, userToken);
        state = state.copyWith(status: CoursesStatus.success, courses: courses);
      } catch (e) {
        state = state.copyWith(status: CoursesStatus.error);
      }
  }

  Course getCourseById(int courseId) {
    return state.courses.firstWhere((course) => course.id == courseId);
  }

  void setCourses(List<Course> courses) {
    state = state.copyWith(courses: courses, status: CoursesStatus.success);
  }

  void setError() {
    state = state.copyWith(status: CoursesStatus.error);
  }
}

// --------- Estado
enum CoursesStatus { initial, loading, success, error }

class CoursesState {
  final List<Course> courses;
  final CoursesStatus status;

  CoursesState({
    this.courses = const [], 
    this.status = CoursesStatus.initial
  });

  CoursesState copyWith({
    List<Course>? courses,
    CoursesStatus? status,
  }) {
    return CoursesState(
      status: status ?? this.status,
      courses: courses ?? this.courses,
    );
  }
}
