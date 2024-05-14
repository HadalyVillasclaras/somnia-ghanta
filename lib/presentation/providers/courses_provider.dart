import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/infraestructure/datasources/courses_datasource_impl.dart';

final coursesProvider = StateNotifierProvider<CoursesNotifier, List<Course>>((ref) {
  return CoursesNotifier();
});

class CoursesNotifier extends StateNotifier<List<Course>> {
  CoursesNotifier() : super(<Course>[]);

  final CoursesDatasource _coursesDatasource = CoursesDatasourceImpl();

   bool isLoading = true;

    Future<Subphase> getSubphaseById(int courseId, int phaseId, int subphaseId) async {
    final subphase = await _coursesDatasource.getSubphaseById(subphaseId);
    return subphase;
  }

  Future<void> getCourses() async {
    final courses = await _coursesDatasource.getCourses();
    state = courses.$1;

    isLoading = false;
  }

  Future<void> getUserCourses(String userToken) async {
    isLoading = true;
    final courses = await _coursesDatasource.getUserCourses(userToken);
    state = courses.$1; 
    isLoading = false;
  }

  // No se usa
  // Course getCourseById(int courseId) {
  //   return state.firstWhere((Course course) => course.id == courseId); // asi no funcion xk no lo setea
  // }

  // No se usa
  // Phase getCurrentPhaseByCourseId(int courseId) {
  //   final course = getCourseById(courseId);
  //   return course.phases[course.currentPhase! - 1];
  // }

  Subphase  getSubphase(int courseId, int phaseId, int subphaseId) {
    final course = state.firstWhere((Course course) => course.id == courseId);
    final phase = course.phases[0];
    return phase.subphases.where((element) => element.id == subphaseId).first;
  }


}
