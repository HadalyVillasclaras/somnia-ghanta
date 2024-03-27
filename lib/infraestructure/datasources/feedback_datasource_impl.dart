import 'package:dio/dio.dart';
import 'package:ghanta/config/_config.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/errors/courses_errors.dart';
import 'package:ghanta/infraestructure/mappers/feedback_mapper.dart';
import 'package:ghanta/infraestructure/models/api_models/feedback_api.dart';
import 'package:ghanta/infraestructure/services/key_value_storage_service_impl.dart';

class FeedbackDatasourceImpl extends FeedbackDatasource {
  @override
  Future<List<Feedback>> getUserFeedback(String userToken) async {
    try {
      final token = await KeyValueStorageServiceImpl().getValue<String>('token') ?? '';
      final response = await ApiConfig.dio.get('/users/6/feedbacks',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }));

      final feedbackApiModelList = List<FeedbackApiModel>.from(
          response.data['data'].map((x) => FeedbackApiModel.fromJson(x)));

      final feedbacks = feedbackApiModelList.map((e) => FeedbackMapper.feedbackApiModelToEntity(e)).toList();   

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
