class FeedbackEvent {
  final DateTime date;
  final String feedback;
  final int emotion;

  FeedbackEvent({
    required this.date,
    required this.feedback,
    required this.emotion,
  });

   @override
  String toString() {
    String formattedDate = "${date.year}-${date.month}-${date.day}";
    return "Date: $formattedDate, Feedback: $feedback, Emotion: $emotion";
  }
}