class FeedbackApiModel {
    final int id;
    final dynamic activityId;
    final String activityName;
    final dynamic userId;
    final String userName;
    final String feedback;
    final DateTime date;
    final dynamic emotion;

    FeedbackApiModel({
      required this.id,
      required this.activityId,
      required this.activityName,
      required this.userId,
      required this.userName,
      required this.feedback,
      required this.date,
      required this.emotion,
    });

    factory FeedbackApiModel.fromJson(Map<String, dynamic> json) {
      return FeedbackApiModel(
      id: json["id"],
      activityId: json["activity_id"],
      activityName: json["activity_name"],
      userId: json["user_id"],
      userName: json["user_name"],
      feedback: json["feedback"],
      date: DateTime.parse(json["date"]),
      emotion: json["emotion"],
    );}
}
