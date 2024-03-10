
import 'dart:convert';

import 'package:ghanta/infraestructure/models/api_models/phase_api.dart';

class CourseApiModel {
    final int id;
    final String titleEs;
    final String titleCa;
    final int price;
    final String image;
    final String descriptionEs;
    final String descriptionCa;
    final int userId;
    final String? userName;
    final DateTime createdAt;
    final DateTime updatedAt;
    final List<PhaseApiModel> phases;
    final CurrentCourseStatus? currentCourseStatus;

    CourseApiModel({
        required this.id,
        required this.titleEs,
        required this.titleCa,
        required this.price,
        required this.image,
        required this.descriptionEs,
        required this.descriptionCa,
        required this.userId,
        required this.userName,
        required this.createdAt,
        required this.updatedAt,
        required this.phases,
        this.currentCourseStatus,
    });

    factory CourseApiModel.fromJson(Map<String, dynamic> json) => CourseApiModel(
        id: json["id"],
        titleEs: json["title_es"],
        titleCa: json["title_ca"],
        price: json["price"],
        image: json["image"],
        descriptionEs: json["description_es"],
        descriptionCa: json["description_ca"],
        userId: json["user_id"],
        userName: json["user_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        phases: List<PhaseApiModel>.from(json["phases"].map((x) => PhaseApiModel.fromJson(x))),
        currentCourseStatus: json["current_course_status"] == null ? null : CurrentCourseStatus.fromJson(json["current_course_status"]),
    );

}

class CurrentCourseStatus {
    final int userId;
    final int courseId;
    final int? currentPhase;
    final int? currentSubphase;

    CurrentCourseStatus({
        required this.userId,
        required this.courseId,
        required this.currentPhase,
        required this.currentSubphase,
    });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'userId': userId});
    result.addAll({'courseId': courseId});
    if(currentPhase != null){
      result.addAll({'currentPhase': currentPhase});
    }
    if(currentSubphase != null){
      result.addAll({'currentSubphase': currentSubphase});
    }
  
    return result;
  }

  factory CurrentCourseStatus.fromMap(Map<String, dynamic> map) {
    return CurrentCourseStatus(
      userId: map['userId']?.toInt() ?? 0,
      courseId: map['courseId']?.toInt() ?? 0,
      currentPhase: map['currentPhase']?.toInt(),
      currentSubphase: map['currentSubphase']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentCourseStatus.fromJson(Map<String, dynamic> json) => CurrentCourseStatus(
        userId: json["user_id"],
        courseId: json["course_id"],
        currentPhase: json["current_phase"],
        currentSubphase: json["current_subphase"],
    );
}
