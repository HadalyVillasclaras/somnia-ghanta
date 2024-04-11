import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/models/responses/add_feedback_api_response.dart';

abstract class FeedbackDatasource {
  Future<List<UserFeedback>> getUserFeedback(int userId, String userToken);
  Future<AddFeedbackApiResponse> addUserFeedback(
    String token,
    int activityId, 
    int userId,
    DateTime date,
    int emotion, 
    String feedback
  );

}