import 'package:dio/dio.dart';
import 'package:ghanta/config/_config.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/errors/courses_errors.dart';
import 'package:ghanta/infraestructure/mappers/user_feedback_mapper.dart';

import 'package:ghanta/infraestructure/models/api_models/feedback_api.dart';
import 'package:ghanta/infraestructure/models/responses/add_feedback_api_response.dart';
import 'package:ghanta/infraestructure/services/key_value_storage_service_impl.dart';

class FeedbackDatasourceImpl extends FeedbackDatasource {
  @override
  Future<List<UserFeedback>> getUserFeedback(int userId, String userToken) async {
    try {
      final token = await KeyValueStorageServiceImpl().getValue<String>('token') ?? '';
      final response = await ApiConfig.dio.get('/users/$userId/feedbacks',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }));

      final feedbackApiModelList = List<FeedbackApiModel>.from(
          response.data['data'].map((feedback) => FeedbackApiModel.fromJson(feedback)));

      final userFeedbacks = UserFeedbackMapper.fromFeedbackApiModelList(feedbackApiModelList); 
      return userFeedbacks;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw NetworkError();
      } else {
        rethrow;
      }
    } catch (e) {
       throw Exception(e);
    }
  }

  @override
  Future<AddFeedbackApiResponse> addUserFeedback(
    String token,
    int activityId, 
    int userId,
    DateTime date,
    int emotion, 
    String feedback) async{

      try {
        final formData = FormData.fromMap({
          'activity_id': activityId.toString(),
          'user_id': userId.toString(),
          'date': DateTime.now(),
          'emotion': emotion,
          'feedback': feedback,
        });
    
        final response = await ApiConfig.dio.post('/feedbacks',
          data: formData, 
          options: Options(
            headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            },
            contentType: 'multipart/form-data'
          ));

        final feedbackResponse = AddFeedbackApiResponse.fromJson(response.data);

        return feedbackResponse;
      } catch (e) {
        if (e is DioException) {
          String errorMessage = e.response?.data['errors']['feedback'][0]  ?? 'Se ha producido un error y la información no ha podido ser guardada.';
            throw Exception(errorMessage);
        } else {
          throw Exception('Se ha producido un error y la información no ha podido ser guardada.');
        }
    }
  }
}

// 400 Data: {data: null, status: false, 
////message: Feedback not created, user already made feedback in this activity, code: 400, errors: null}


//401
// {data: null, status: false, code: 401, 
////message: Unauthenticated., developer_message: Unauthenticated.}