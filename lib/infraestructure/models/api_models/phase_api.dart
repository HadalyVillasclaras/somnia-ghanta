import 'package:ghanta/infraestructure/models/api_models/subphase_api.dart';

class PhaseApiModel {
    final int id;
    final String titleEs;
    final String titleCa;
    final int duration;
    final dynamic descriptionEs;
    final dynamic descriptionCa;
    final int courseId;
    final String? courseName;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int order;
    final List<SubphaseApiModel>? subphases;

    PhaseApiModel({
        required this.id,
        required this.titleEs,
        required this.titleCa,
        required this.duration,
        required this.descriptionEs,
        required this.descriptionCa,
        required this.courseId,
        this.courseName,
        required this.createdAt,
        required this.updatedAt,
        required this.order,
        this.subphases,
    });

    //Empty constructor

    factory PhaseApiModel.empty() => PhaseApiModel(
      id: 0,
      titleEs: "",
      titleCa: "",
      duration: 0,
      descriptionEs: "",
      descriptionCa: "",
      courseId: 0,
      courseName: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      order: 0,
      subphases: [],
    );

    

    factory PhaseApiModel.fromJson(Map<String, dynamic> json) => PhaseApiModel(
        id: json["id"],
        titleEs: json["title_es"],
        titleCa: json["title_ca"],
        duration: json["duration"],
        descriptionEs: json["description_es"],
        descriptionCa: json["description_ca"],
        courseId: json["course_id"],
        courseName: json["course_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        order: json["order"],
        subphases: json["subphases"] == null ? [] : List<SubphaseApiModel>.from(json["subphases"].map((x) => SubphaseApiModel.fromJson(x))),
    );

}