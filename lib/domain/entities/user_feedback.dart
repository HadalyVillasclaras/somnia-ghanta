class UserFeedback {
  final DateTime date;
  final List<FeedbackDetail> feedbackDetails;

// Constructor
UserFeedback({
    required this.date,
    required this.feedbackDetails,
  });
}

class FeedbackDetail {
  final String feedback;
  final int emotion;

  FeedbackDetail({
    required this.feedback,
    required this.emotion,
  });
}
