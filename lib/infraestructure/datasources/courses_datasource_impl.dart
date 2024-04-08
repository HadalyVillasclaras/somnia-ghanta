import 'package:dio/dio.dart';
import 'package:ghanta/config/_config.dart';
import 'package:ghanta/config/constants/enviroment.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/errors/courses_errors.dart';
import 'package:ghanta/infraestructure/mappers/courses_mapper.dart';
import 'package:ghanta/infraestructure/models/api_models/course_api.dart';
import 'package:ghanta/infraestructure/models/responses/courses_single_api_response.dart';
import 'package:ghanta/infraestructure/services/key_value_storage_service_impl.dart';

class CoursesDatasourceImpl extends CoursesDatasource {
  @override
  Future<(Course, String)> getCourse(String id) async {
    final String token =
        await KeyValueStorageServiceImpl().getValue<String>('token') ?? '';
    final response = await ApiConfig.dio.get('/courses/$id',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }));

    final course = CoursesSingleApiResponse.fromJson(response.data).data;

    return (
      CoursesMapper.coursesApiModelToEntity(course),
      response.statusMessage!
    );
  }

  @override
  Future<(List<Course>, String)> getCourses() async {
    final response = await ApiConfig.dio.get('/courses',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Environment.apiToken}',
          },
        ));

    final courses = List<CourseApiModel>.from(
        response.data['data'].map((x) => CourseApiModel.fromJson(x)));

    return (
      courses.map((e) => CoursesMapper.coursesApiModelToEntity(e)).toList(),
      response.statusMessage!
    );
  }

  @override
  Future<(List<Course>, String)> getUserCourses(String userToken) async {
    try {
      final token =
          await KeyValueStorageServiceImpl().getValue<String>('token') ?? '';
      final response = await ApiConfig.dio.get('/users/6/enrolledCourses',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));

      final enrolledCourses = response.data['data'];
      enrolledCourses.forEach((course) {
        // print(course['id']);
      });

      // List<dynamic> coursesList = await Future.wait(
      //   enrolledCourses.map((course) async => await getCourse(course['id'].toString())).toList(),
      // );


      final courseData;

      final courses = List<CourseApiModel>.from(
          response.data['data'].map((x) => CourseApiModel.fromJson(x)));
          
      return (
        courses.map((e) => CoursesMapper.coursesApiModelToEntity(e)).toList(),
        response.statusMessage!
      );
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw NetworkError();
      } else {
        rethrow;
      }
    }
  }


  @override
  Future<List<Course>> getNewUserCourses(String userToken) async {
    try {
      final token =
          await KeyValueStorageServiceImpl().getValue<String>('token') ?? '';
      final response = await ApiConfig.dio.get('/users/6/enrolledCourses',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));

      final enrolledCourses = response.data['data'];
      final coursesApiModel = List<CourseApiModel>.from(
        enrolledCourses.map((x) => CourseApiModel.fromJson(x)));
      
      final courses = coursesApiModel.map((e) => CoursesMapper.coursesApiModelToEntity(e)).toList();
      
      return courses;

    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw NetworkError();
      } else {
        rethrow;
      }
    }
  }


}
