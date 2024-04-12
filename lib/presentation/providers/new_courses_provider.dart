import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/enviroment.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/domain/entities/phase.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/infraestructure/datasources/courses_datasource_impl.dart';
import 'package:ghanta/infraestructure/repositories/courses_repository_impl.dart';
import 'package:ghanta/presentation/providers/auth/auth_provider.dart';

final testCourseProvider = FutureProvider<List<Course>>((ref) async {
  final coursesRepository = CoursesDatasourceImpl();
  final authState = ref.read(authProvider);
  final userToken = authState.user?.token; 

  await Future.delayed(Duration(seconds: 2));
  final courses = await coursesRepository.getNewUserCourses(userToken!);
  
  return courses;
});


final coursesStateProvider = StateNotifierProvider<CoursesNotifier, CoursesState>((ref) {
  return CoursesNotifier();
});

class CoursesNotifier extends StateNotifier<CoursesState> {
  CoursesNotifier() : super(CoursesState());
  final CoursesDatasource _coursesDatasource = CoursesDatasourceImpl();

  Future<void> getUserCourses(userToken) async {
    state = state.copyWith(status: CoursesStatus.loading);
      try {
        final courses = await _coursesDatasource.getNewUserCourses(userToken);
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


// ---------------------
final newCoursesProvider = StateNotifierProvider<NewCoursesNotifier, CoursesState>((ref) {
  final coursesRepositoryImpl = CoursesRepositoryImpl(CoursesDatasourceImpl());

  return NewCoursesNotifier(coursesRepositoryImpl);
});

class NewCoursesNotifier extends StateNotifier<CoursesState> {
  final CoursesRepository coursesRepository;
  final userToken = Environment.apiToken;

  NewCoursesNotifier(
    this.coursesRepository
  ) : super(CoursesState());


  Future<void> getUserCourses(String userToken) async {
    state = state.copyWith(status: CoursesStatus.loading);
    try {
      final courses = await coursesRepository.getNewUserCourses(userToken);
      state = state.copyWith(status: CoursesStatus.success, courses: courses);
    } catch (e) {
      print(e);
      state = state.copyWith(status: CoursesStatus.error);
    }
  }
}