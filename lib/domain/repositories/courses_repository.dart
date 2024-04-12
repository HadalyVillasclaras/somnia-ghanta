import 'package:ghanta/domain/_domain.dart';

abstract class CoursesRepository {
  
  Future<(List<Course>, String)> getCourses();
  
  Future<(Course, String)> getCourse(String id);

  Future<(List<Course>, String)> getUserCourses(String userToken);
  Future<List<Course>> getNewUserCourses(int userId, String userToken);


}