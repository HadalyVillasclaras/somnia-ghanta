
import 'package:ghanta/infraestructure/models/api_models/course_api.dart';

class CoursesSingleApiResponse {
    final CourseApiModel data;
    final bool status;
    final String message;
    final int code;

    CoursesSingleApiResponse({
        required this.data,
        required this.status,
        required this.message,
        required this.code,
    });

    factory CoursesSingleApiResponse.fromJson(Map<String, dynamic> json) => CoursesSingleApiResponse(
        data: CourseApiModel.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
        code: json["code"],
    );

}


