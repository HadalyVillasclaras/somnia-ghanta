import 'package:ghanta/infraestructure/models/api_models/course_api.dart';

class UserEnrolledCoursesResponse {
    final List<CourseApiModel> data;
    final String message;
    final bool status;
    final int code;

    UserEnrolledCoursesResponse({
        required this.data,
        required this.message,
        required this.status,
        required this.code,
    });
}
