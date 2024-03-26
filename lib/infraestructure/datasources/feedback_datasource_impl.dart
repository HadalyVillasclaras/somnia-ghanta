import 'package:dio/dio.dart';
import 'package:ghanta/config/_config.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/errors/courses_errors.dart';
import 'package:ghanta/infraestructure/models/api_models/feedback_api.dart';
import 'package:ghanta/infraestructure/services/key_value_storage_service_impl.dart';

class FeedbackDatasourceImpl extends FeedbackDatasource {
  @override
  Future<(List<Feedback>, String)> getUserFeedback(String userToken) async {
    try {
      final token = await KeyValueStorageServiceImpl().getValue<String>('token') ?? '';
      final response = await ApiConfig.dio.get('/users/6/feedbacks',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }));

      final feedbacks = response.data['data'];
      feedbacks.forEach((feedback) {
        // print(course['id']);
      });
      

      final courseData;

      final feedbackss = List<FeedbackApiModel>.from(
          response.data['data'].map((x) => FeedbackApiModel.fromJson(x)));
          
      return feedbacks;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw NetworkError();
      } else {
        rethrow;
      }
    }
  }
}
