

import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/domain/entities/subphase.dart';

abstract class CoursesDatasource {
  
  Future<(List<Course>, String)> getCourses();
  
  Future<(Course, String)> getCourse(String id);

  Future<(List<Course>, String)> getUserCourses(String userToken);

  Future<List<Course> > getNewUserCourses(int userId, String userToken);

  Future<Subphase> getSubphaseById(int id);

}