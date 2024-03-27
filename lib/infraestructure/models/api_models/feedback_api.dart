class FeedbackApiModel {
    // final List<PhaseApiModel> phases;
    // final CurrentCourseStatus? currentCourseStatus;

    final int id;
    final int activityId;
    final String activityName;
    final int userId;
    final String userName;
    final String feedback;
    final DateTime date;
    final int emotion;

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

    factory FeedbackApiModel.fromJson(Map<String, dynamic> json) => FeedbackApiModel(
      id: json["id"],
      activityId: json["activity_id"],
      activityName: json["activity_name"],
      userId: json["user_id"],
      userName: json["user_name"],
      feedback: json["feedback"],
      date: DateTime.parse(json["date"]),
      emotion: json["emotion"],
    );

}
