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
  Future<(List<Course>, String)> getUserCourses(String userToken) {
    return _datasource.getUserCourses(userToken);
  }
  

    @override
  Future<List<Course>> getNewUserCourses(int userId, String userToken) {
    return _datasource.getNewUserCourses(userId, userToken);
  }

}