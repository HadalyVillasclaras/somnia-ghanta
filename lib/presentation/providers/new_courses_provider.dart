import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/enviroment.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/domain/entities/phase.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/infraestructure/datasources/courses_datasource_impl.dart';
import 'package:ghanta/infraestructure/repositories/courses_repository_impl.dart';

final newCoursesProvider = StateNotifierProvider<NewCoursesNotifier, NewCoursesState>((ref) {
  final coursesRepositoryImpl = CoursesRepositoryImpl(CoursesDatasourceImpl());

  return NewCoursesNotifier(coursesRepositoryImpl);
});

class NewCoursesNotifier extends StateNotifier<NewCoursesState> {
  final CoursesRepository coursesRepository;
  final userToken = Environment.apiToken;

  NewCoursesNotifier(
    this.coursesRepository
  ) : super(NewCoursesState()){
    getUserCourses(userToken);
  }

   bool isLoading = true;

  Future<void> getUserCourses(String userToken) async {
    state = state.copyWith(status: CoursesStatus.loading);
    isLoading = true;
    try {
      final courses = await coursesRepository.getNewUserCourses(userToken);
      state = state.copyWith(status: CoursesStatus.success, courses: courses);
    } catch (e) {
      print(e);
      state = state.copyWith(status: CoursesStatus.error);
    }

    isLoading = false;
  }
}

// --------- Estado
enum CoursesStatus { initial, loading, success, error }

class NewCoursesState {
  final List<Course> courses;
  final CoursesStatus status;

  NewCoursesState({
    this.courses = const [], 
    this.status = CoursesStatus.initial
  });

  NewCoursesState copyWith({
    List<Course>? courses,
    CoursesStatus? status,
  }) {
    return NewCoursesState(
      status: status ?? this.status,
      courses: courses ?? this.courses,
    );
  }
}