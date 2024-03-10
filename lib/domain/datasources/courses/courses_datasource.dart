

import 'package:ghanta/domain/_domain.dart';

abstract class CoursesDatasource {
  
  Future<(List<Course>, String)> getCourses();
  
  Future<(Course, String)> getCourse(String id);

  Future<(List<Course>, String)> getUserCourses(String userToken);

}