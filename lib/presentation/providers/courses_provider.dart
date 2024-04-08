import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/domain/entities/phase.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/infraestructure/datasources/courses_datasource_impl.dart';

final coursesProvider = StateNotifierProvider<CoursesNotifier, List<Course>>((ref) {
  return CoursesNotifier();
});

class CoursesNotifier extends StateNotifier<List<Course>> {
  CoursesNotifier() : super(<Course>[]);

  final CoursesDatasource _coursesDatasource = CoursesDatasourceImpl();

   bool isLoading = true;

  Future<void> getCourses() async {
    final courses = await _coursesDatasource.getCourses();
    state = courses.$1;

    isLoading = false;
  }

  Future<void> getUserCourses(String userToken) async {
    isLoading = true;
    final courses = await _coursesDatasource.getUserCourses(userToken);
    // getCourseById2('1');
    state = courses.$1; //aquí se setean los cursos
    isLoading = false;
  }

  Future<void> getCourseById2(String id) async {
    isLoading = true;
    final courses = await _coursesDatasource.getCourse(id);
    state = [courses.$1]; 
    isLoading = false;
  }

  Course getCourseById(int courseId) {
    return state.firstWhere((Course course) => course.id == courseId); // asi no funcion xk no lo setea
  }

  Phase getCurrentPhaseByCourseId(int courseId) {
    final course = getCourseById(courseId);
    return course.phases[course.currentPhase! - 1];
  }

  Subphase  getSubphase(int courseId, int phaseId, int subphaseId) {
    final course = getCourseById(courseId);
    final phase = course.phases[phaseId];
    return phase.subphases.where((element) => element.id == subphaseId).first;
  }
}
