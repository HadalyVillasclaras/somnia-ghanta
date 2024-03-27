import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/models/api_models/feedback_api.dart';

class UserFeedbackMapper {
  static List<UserFeedback> fromFeedbackApiModelList(List<FeedbackApiModel> feedbackApiModels) {
    Map<DateTime, List<FeedbackDetail>> groupedFeedbacks = {};

    // Feedbacks by date
    for (var model in feedbackApiModels) {
      final feedbackDetail = FeedbackDetail(feedback: model.feedback, emotion: model.emotion);

      groupedFeedbacks.update(
        model.date,
        (existingFeedbacks) => [...existingFeedbacks, feedbackDetail],
        ifAbsent: () => [feedbackDetail],
      );
    }

    return groupedFeedbacks.entries.map((entry) {
      return UserFeedback(date: entry.key, feedbackDetails: entry.value);
    }).toList();
  }
}