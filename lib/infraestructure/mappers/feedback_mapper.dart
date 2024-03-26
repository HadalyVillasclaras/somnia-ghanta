import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/models/api_models/feedback_api.dart';

class FeedbackMapper {

  static Feedback feedbackApiModelToEntity (FeedbackApiModel feedbackApiModel) {
    return Feedback(
      id: feedbackApiModel.id,
      activityId: feedbackApiModel.activityId,
      activityName: feedbackApiModel.activityName,
      userId: feedbackApiModel.userId.toString(),
      userName: feedbackApiModel.userName,
      feedback: feedbackApiModel.feedback,
      date: feedbackApiModel.date.toString(),
      emotion: feedbackApiModel.emotion,
    );
  }
}