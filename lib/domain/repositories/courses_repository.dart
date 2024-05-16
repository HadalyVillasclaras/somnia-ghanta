import 'package:ghanta/domain/_domain.dart';

abstract class CoursesRepository {
  Future<(List<Course>, String)> getCourses();

  Future<(Course, String)> getCourse(String id);

  Future<List<Course>> getUserCourses(int userId, String userToken);
}
