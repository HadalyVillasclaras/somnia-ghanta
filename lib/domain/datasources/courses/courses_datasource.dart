import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/domain/entities/subphase.dart';

abstract class CoursesDatasource {
  
  Future<(List<Course>, String)> getCourses();
  
  Future<(Course, String)> getCourse(String id);

  Future<List<Course> > getUserCourses(int userId, String userToken);

  Future<Subphase> getSubphaseById(int id);
}