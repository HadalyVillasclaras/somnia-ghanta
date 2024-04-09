class Feedback {
  final int id;
  final int activityId;
  final String activityName;
  final String userId;
  final String userName;
  final String feedback;
  final String date;
  final int emotion;


// Constructor
Feedback({
    required this.id,
    required this.activityId,
    required this.activityName,
    required this.userId,
    required this.userName,
    required this.feedback,
    required this.date,
    required this.emotion,
  });

  /// TO JSON
 Map<String, dynamic> toJson() => {
    'id': id,
    'activityId': activityId,
    'activityName': activityName,
    'userId': userId,
    'userName': userName,
    'feedback': feedback,
    'date': date, 
    'emotion': emotion,
  };
  
  @override
  String toString() {
    return 'Feedback{id: $id, activityId: $activityId, activityName: $activityName, userId: $userId, userName: $userName, feedback: $feedback, date: $date, emotion: $emotion}';
  }

  // static Role roleFromJson(String role) {
  //   switch (role) {
  //     case 'ROLE_ADMIN':
  //       return Role.roleAdmin;
  //     case 'ROLE_USER':
  //       return Role.roleUser;
  //     case 'ROLE_COURSE_MANAGER':
  //       return Role.roleCourseManager;
  //     default:
  //       return Role.roleUser;
  //   }
  // }
}
