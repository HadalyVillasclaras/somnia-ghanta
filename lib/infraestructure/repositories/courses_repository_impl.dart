import 'package:ghanta/domain/_domain.dart';

class CoursesRepositoryImpl extends CoursesRepository {

  final CoursesDatasource _datasource;

  CoursesRepositoryImpl(this._datasource);

  @override
  Future<(Course, String)> getCourse(String id) {
    return _datasource.getCourse(id);
  }

  @override
  Future<(List<Course>, String)> getCourses() {
    return _datasource.getCourses();
  }

  @override
  Future<List<Course>> getUserCourses(int userId, String userToken) {
    return _datasource.getUserCourses(userId, userToken);
  }
}