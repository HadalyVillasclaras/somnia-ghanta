import 'package:ghanta/infraestructure/models/api_models/activity/activity_api.dart';
import 'package:ghanta/infraestructure/models/api_models/phase_api.dart';

class SubphaseApiModel {
    final int id;
    final String titleEs;
    final String titleCa;
    final String estimatedTime;
    final int order;
    final int phaseId;
    final int? courseId;
    final PhaseApiModel? phase;
    final String subphaseTypologyTitleEs;
    final String subphaseTypologyTitleCa;
    final String type;
    final int subphaseTyplogyId;
    final DateTime createdAt;
    final DateTime updatedAt;
    final List<ActivityApiModel> activities;

    SubphaseApiModel({
        required this.id,
        required this.titleEs,
        required this.titleCa,
        required this.estimatedTime,
        required this.order,
        required this.phaseId,
        this.courseId,
        required this.phase,
        required this.subphaseTypologyTitleEs,
        required this.subphaseTypologyTitleCa,
        required this.type,
        required this.subphaseTyplogyId,
        required this.createdAt,
        required this.updatedAt,
        required this.activities,
    });

    factory SubphaseApiModel.fromJson(Map<String, dynamic> json,  [int? courseId]) => SubphaseApiModel(
        id: json["id"],
        titleEs: json["title_es"],
        titleCa: json["title_ca"],
        estimatedTime: json["estimated_time"],
        order: json["order"],
        courseId: courseId,
        phaseId: json["phase_id"],
        phase: json["phase"] == null ? null : PhaseApiModel.fromJson(json["phase"]),
        subphaseTypologyTitleEs: json["subphase_typology_title_es"] ?? "",
        subphaseTypologyTitleCa: json["subphase_typology_title_ca"] ?? "",
        type: json["type"],
        subphaseTyplogyId: json["subphase_typlogy_id"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        activities: json["activities"] == null ? [] : List<ActivityApiModel>.from(json["activities"].map((x) => ActivityApiModel.fromJson(x))),
    );


}